Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSEALRO>; Wed, 1 May 2002 07:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSEALRN>; Wed, 1 May 2002 07:17:13 -0400
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:2308 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S293722AbSEALRM>; Wed, 1 May 2002 07:17:12 -0400
Message-Id: <5.1.0.14.2.20020501130602.00cabaf0@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 01 May 2002 13:14:25 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: SEVERE Problems in 2.5.12 at uid0 access
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


server01:/ # cd /var/log

server01:/var/log# ls -laF
<snip>
drwxr-s---    2 mail     adm           104 Mar 12 23:29 exim/
<snip>

server01:/var/log# ls -laF exim
ls: exim/.: Permission denied
ls: exim/..: Permission denied
ls: exim/rejectlog: Permission denied
ls: exim/mainlog: Permission denied
total 0
server01:/var/log# whoami
root
server01:/var/log# id
uid=0(root) gid=0(root) groups=0(root)
server01:/var/log#


What hell is that? could be a ReiseFs problem (/var is a ReiserFs partition)
Ok, ill try on a ext3 partition:

server01:/var/log# cd /boot
server01:/boot# mkdir a
server01:/boot# ls -laF
total 2368
<snip>
drwxr-xr-x    2 root     root         4096 May  1 12:08 a/
<snip>
server01:/boot# chown mail.adm a
server01:/boot# chmod 750 a
server01:/boot# ls -laF
total 2368
<snip>
drwxr-x---    2 mail     adm          4096 May  1 12:08 a/
<snip>
server01:/boot# ls -laF a
ls: a/.: Permission denied
ls: a/..: Permission denied
total 0
server01:/boot# id
uid=0(root) gid=0(root) groups=0(root)
server01:/boot#


???? WELL?????
reboting to previous kernel version (2.5.8-pre2+1_6_reiserfs patchs)

