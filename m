Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUBDToK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbUBDToJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:44:09 -0500
Received: from mail.ddc-ny.com ([12.35.229.4]:33542 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S263868AbUBDToE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:44:04 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16F34@DDCNYNTD>
From: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
To: "'Valdis.Kletnieks@vt.edu'" <Valdis.Kletnieks@vt.edu>,
       "Randazzo, Michael" <RANDAZZO@ddc-web.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.x POSIX Compliance/Conformance... 
Date: Wed, 4 Feb 2004 14:44:00 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was using at sem_close(), sem_destroy90, sem_open() ...

according to Posix.4, these are defined in semaphore.h - but
are not defined in /lib/modules/<uname -r>/build/include/semaphore.h

Are Posix.4 calls only for userspace?

M.

-----Original Message-----
From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu]
Sent: Wednesday, February 04, 2004 2:41 PM
To: Randazzo, Michael
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: Kernel 2.x POSIX Compliance/Conformance... 


On Wed, 04 Feb 2004 14:30:39 EST, "Randazzo, Michael" <RANDAZZO@ddc-web.com>
said:

> I have made attempts to use (Posix semaphores) in my LKM, but find 
> no POSIX support in /lib/modules/<uname -r>/build/include/unistd.h

Attempting to use syscalls intended for userspace while inside the kernel
is generally regarded as Bad Juju.

'man semctl' says:

     Under  Linux,  the  function semctl is not a system call, but is imple-
       mented via the system call ipc(2).

#define __NR_ipc                117

is what you weren't finding in unistd.h
 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

