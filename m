Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271388AbRIAVHd>; Sat, 1 Sep 2001 17:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271401AbRIAVHZ>; Sat, 1 Sep 2001 17:07:25 -0400
Received: from oe24.law9.hotmail.com ([64.4.8.81]:41230 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S271388AbRIAVHQ>;
	Sat, 1 Sep 2001 17:07:16 -0400
X-Originating-IP: [65.92.117.123]
From: "Camiel Vanderhoeven" <camiel_toronto@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: CR3 (PDPTR) format when PAE is enabled
Date: Sat, 1 Sep 2001 17:07:42 -0400
Message-ID: <004501c1332a$2398bd20$0100a8c0@kiosks.hospitaladmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
X-OriginalArrivalTime: 01 Sep 2001 21:07:29.0952 (UTC) FILETIME=[1C4CC200:01C1332A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am confused about Intel's documentation regarding PAE. When PAE is
enabled, CR3 contains a few flags (write-through and cache disabled), 3
reserved bits, and - and here is my confusion - a 27-bit
page-directory-pointer-table base address field, "providing the 27 most
significant bits of the physical address of the PDPT, which forces the
table to be located on a 32-byte boundary."

Now, in PAE, the physical address is a 36-bit value. If we take off 27
bits, there are 9 bits left, forcing the table to be located on a
512-byte boundary. 

Is this correct, or do the 27-bits present the bits 6..31 of the
physical address, forcing the table to be located on a 32-byte boundary
AND below 4GB (physical)?

Camiel.
