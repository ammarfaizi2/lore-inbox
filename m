Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSGIG6V>; Tue, 9 Jul 2002 02:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSGIG6U>; Tue, 9 Jul 2002 02:58:20 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:41878 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317324AbSGIG6S>; Tue, 9 Jul 2002 02:58:18 -0400
Message-ID: <001101c22712$f51d54f0$0700a8c0@ibammer>
From: IB-Ammer@t-online.de (=?iso-8859-1?Q?Dr._Markus_Ammer=2C_Ingenieurb=FCro_Ammer?=)
To: <linux-kernel@vger.kernel.org>
Subject: kernel op-locks not in alpha-kernel ?
Date: Tue, 9 Jul 2002 08:36:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

following has been posted to samba mailing list, but Gerald Carter
<jerry@samba.org>  answered:

> You'll probably have to bring this up with the linux-kernel mailing list.
> Not sure who is maintaining that code in the kernel now.


I have a Compaq Alpha server with Linux 2.4.18 and samba 2.2.4 and
NT-clients.

Problem: After accessing a file from a NT-client this file cannot be
accessed on the Linux side for a while.

Example:
Creating the file on the server (via telnet session):
     echo test >file

accessing the file from the NT-client (gives "test"):
     TYPE file

try to access it on the server (via telnet session):
     cat test
 cat: file: Invalid argument

After waiting approx. 40 sec. it succeeds.


This problem does not occur with "kernel oplocks=no" in /etc/smb.conf, but
file contents are not consistent then.

The same configuration on an Intel server (2.4.16, samba 2.2.3a) works.


Markus.
(Please send CC to me.)


