Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTLaTmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTLaTmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:42:11 -0500
Received: from mail2.megatrends.com ([155.229.80.16]:44562 "EHLO
	atl-ms1.megatrends.com") by vger.kernel.org with ESMTP
	id S265252AbTLaTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:42:09 -0500
Message-ID: <8CCBDD5583C50E4196F012E79439B45C0568D80C@atl-ms1.megatrends.com>
From: Srikumar Subramanian <SrikumarS@ami.com>
To: "'arjanv@redhat.com'" <arjanv@redhat.com>,
       Srikumar Subramanian <SrikumarS@ami.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Boopathi Veerappan <BoopathiV@ami.com>
Subject: RE: memory leak in call_usermodehelper()
Date: Wed, 31 Dec 2003 14:43:18 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, I am not intended to have my own syscall.

I am generating a report on all deleted file and directory. For that I
trapped sys_unlink() function and calling a external program using
call_usermodehelper(). Since sys_unlink() is called very frequently in my
case, memory leak caused by calling call_usermodehelper kills all the
process in the system.

Just to narrow down the problem, I introduced my own syscall.

-----Original Message-----
From: Arjan van de Ven [mailto:arjanv@redhat.com]
Sent: Wednesday, December 31, 2003 7:13 AM
To: Srikumar Subramanian
Cc: 'Andrew Morton'; 'linux-kernel@vger.kernel.org'; Boopathi Veerappan
Subject: RE: memory leak in call_usermodehelper()

On Wed, 2003-12-31 at 06:22, Srikumar Subramanian wrote:

>
> Is there any alternative to call_usermodehelper in kernel 2.4.20?
>
most of all don't implement your own syscalls!

> Hi,
> I am using 2.4.20-8 Redhat 9 kernel.
>

well clearly not quite since you're adding syscalls to it.
Also 2.4.20-8 isn't the current Red Hat Linux 9 kernel; 2.4.20-27.9 is.
