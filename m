Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKCTQJ>; Fri, 3 Nov 2000 14:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129042AbQKCTP7>; Fri, 3 Nov 2000 14:15:59 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:13502 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S129034AbQKCTPu>; Fri, 3 Nov 2000 14:15:50 -0500
Message-ID: <3A030EE2.92DC3F2@oracle.com>
Date: Fri, 03 Nov 2000 11:15:46 -0800
From: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Organization: Linux Strategic Business Unit, Oracle Corporation
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Value of TASK_UNMAPPED_SIZE on 2.4
Content-Type: multipart/mixed;
 boundary="------------E7646E6CF7A8BFC1D1841EEE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7646E6CF7A8BFC1D1841EEE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

TASK_UNMAPPED_SIZE is defined in include/asm-i386/processor.h as:

#define TASK_UNMAPPED_SIZE    (TASK_SIZE / 3)

The value of TASK_SIZE is defined as PAGE_OFFSET which is set to 0xC0000000
(page.h).  This works out to be a value of 0x4000000.

The question is:
Are there any negative side effects in defining TASK_UNMAPPED_SIZE to 0x1000000?

By doing this we allow a process to access more memory.  On Oracle it allows us
to grow our buffer size from 1.7 GB to 2.4 GB improving overall performance by
reducing I/O.

Thanks in advance,

--
=======================================================================
  Josue Emmanuel Amaro                         Josue.Amaro@oracle.com
  Linux Products Manager                       Phone:   650.506.1239
  Intel and Linux Technologies Group           Fax:     650.413.0167
=======================================================================


--------------E7646E6CF7A8BFC1D1841EEE
Content-Type: text/x-vcard; charset=us-ascii;
 name="Josue.Amaro.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Josue Emmanuel Amaro
Content-Disposition: attachment;
 filename="Josue.Amaro.vcf"

begin:vcard 
n:Amaro;Josue Emmanuel
tel;cell:650-245-5131
tel;fax:650-413-0167
tel;work:650-506-1239
x-mozilla-html:FALSE
url:http://www.oracle.com
org:Intel and Linux Technologies
version:2.1
email;internet:Josue.Amaro@oracle.com
title:Sr.Product Manager - Linux
adr;quoted-printable:;;500 Oracle Parkway=0D=0AMS1ip4;Redwood Shores;CA;94065;United States
fn:Josue Emmanuel Amaro
end:vcard

--------------E7646E6CF7A8BFC1D1841EEE--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
