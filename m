Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271326AbRHORyE>; Wed, 15 Aug 2001 13:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271331AbRHORxy>; Wed, 15 Aug 2001 13:53:54 -0400
Received: from [195.66.192.167] ([195.66.192.167]:46863 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271326AbRHORxd>; Wed, 15 Aug 2001 13:53:33 -0400
Date: Wed, 15 Aug 2001 20:56:12 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <563618943.20010815205612@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
CC: tridge@linuxcare.com
Subject: smbfs mount failures
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having trouble mounting SMB shares residing on a WinNT machine.
smbclient works fine, but after mounting the same share with the
same username,passwd etc with smbmount and trying to enter
newly mounted dir I see repeating msgs in the logs:

...
smb_catch_keepalive: already done                 [<- this is KERN_ERR!]
smb_retry: successful, new pid=PID, generation=N  [PID is the same, N grows (N++)]
smb_dont_catch_keepalive: server->data_ready == NULL
smb_trans2_request: result=-22, setting invalid
smb_close_socket: still catching keepalives!
smb_catch_keepalive: already done
smb_retry: successful, new pid=PID, generation=N+1
...

Since smbclient is working I presume it is a kernel smbfs bug or some
version mismatch between kernel and smbmount.

smbmount: 2.2.0a
kernel: 2.4.5

CC me. I'm not on the list
-- 
Best regards,
VDA                          mailto:VDA@port.imtp.ilyichevsk.odessa.ua


