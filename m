Return-Path: <linux-kernel-owner+w=401wt.eu-S1751283AbXAPQJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbXAPQJ4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbXAPQJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:09:56 -0500
Received: from web50301.mail.yahoo.com ([206.190.38.55]:22110 "HELO
	web50301.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751283AbXAPQJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:09:56 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 11:09:55 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=0FNpUUY/JxvxsvnHO+nzrhR/BecvfLh96NfpZT0rV15HuYdq8xRy/MfCOe73LJfBqDI4+E2AZGZxqVAasZuDDfW6BTRdM5Ir9GH71yHDccpHuAngoDeKNDn37Tfaa5DkjqIS4xssbzyG/uFyY5lYfw96SzJIC5RRCiZsPh6ZDcY=;
X-YMail-OSG: tSk6a0wVM1lDJoF9WFJjhPfj79gF40kixIAx9QnZm16JIPfxZngiAS0o9.ASEhEugOQhJQjjXD5pt5PhlExfJBt49qd.x5v6N7Vl2mgDqxtsK776hUp79CrkP6kt41Me85J3fvEJHzf3XeZ3mce1mc.BT_dl7oWvHuOTpkWmxFR1DRioPhJNRBqx
Date: Tue, 16 Jan 2007 08:03:14 -0800 (PST)
From: pankaj takawale <pankaj_takawale@yahoo.com>
Subject: pxe booting initrd - kernel panic: No init found
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <774824.83968.qm@web50301.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have compiled & built linux 2.4 kernel, then I
created initrd image using mkinitrd.
Then I mounted this initrd, injected /bin/sh & libc
libraries from system into initrd.

I copied newly built vmlinuz & initrd images to pxe
servert tftp directory.

When I pxe boot my bare-metal machine with these
vmlinuz & initrd , I receive "kernel panic: No Init
found"

After adding debug messages into linux kernel
(init/main.c) I found that execve("/bin/sh"..) is
returning error & errno is EIO (I/O error)

I could see that root filesystem is mounted
successfully.

What causes this error?
Is my initrd is not successfully mounted into ram
using ramdisk image?




 
____________________________________________________________________________________
Want to start your own business?
Learn how on Yahoo! Small Business.
http://smallbusiness.yahoo.com/r-index
