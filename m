Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSDJGBe>; Wed, 10 Apr 2002 02:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDJGBd>; Wed, 10 Apr 2002 02:01:33 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19208 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312460AbSDJGBc>; Wed, 10 Apr 2002 02:01:32 -0400
Message-Id: <200204100558.g3A5wUX04787@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>, linux-kernel@vger.kernel.org
Subject: Re: Ramdisks and tmpfs problems
Date: Wed, 10 Apr 2002 09:01:42 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020409144639.A14678@sin.sloth.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 April 2002 16:46, Geoffrey Gallaway wrote:
> I am attempting to create a central NFS server with a single slackware 8
> installation that many boxes can use as their root disks. I got bootp
> kernel level autoconfiguration working and the test box sucessfully mounts
> the root (/) NFS share. I'm using floppy disks with kernels on diskless
> machines.

Hi there! I've done this. I'm sitting on one of such diskless boxen now.
(actually, it has 2 disks, one is a 1.2G IDE turned into "diskette"
for home <-> work data transfer, other is *ugh* an NT installation).

> The problem occurs for /var, /tmp and /etc. Because each machine will need
> it's own /var, /tmp and /etc I've been trying to create a ramdisk or tmpfs
> filesystem for those partitions on each box. I've been using the system
> initialization scripts to setup these directories and dynamically rewrite
> important files (HOSTNAME, etc) in /etc.
[snip]

Looks like stuff for Al Viro. Consider mailing him with a report
(kernel/GCC version, symptoms etc).

> mount -w -n -t tmpfs -o defaults tmpfs /mnt
> cp -axf /etc /mnt
> mount -w -t tmpfs -o defaults tmpfs /etc
> cp -axf /mnt/etc/* /etc/
> umount /mnt
> # -- Reapeat for /var and /tmp --

Erm... just make a /etc_template, and you'll eliminate one cp.
--
vda
