Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSGQO5U>; Wed, 17 Jul 2002 10:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSGQO5U>; Wed, 17 Jul 2002 10:57:20 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:28060 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315198AbSGQO5T>; Wed, 17 Jul 2002 10:57:19 -0400
Date: Wed, 17 Jul 2002 16:58:22 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207171458.g6HEwM4V028775@burner.fokus.gmd.de>
To: schilling@fokus.gmd.de, viro@math.psu.edu
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       riel@conectiva.com.br
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From viro@math.psu.edu Wed Jul 17 16:00:59 2002

>> Is there any problem with using a ioctl() from upper layer kernel to the low 
>> level drivers (living under the SW raid) to reduce the number of retries to a 
>> reasonable value in this case?
>> 
>> The main design goal for UNIX as to keep it simple. There is no need for a 
>> complex cross layer error control.

>... and ioctl(2) is a gross violation of that design goal.  Ask the authors
>of UNIX how they feel about that kludge, let alone propagation of said kludge
>beyond the TTY layer where it had originated (or about the entire v7 TTY layer,
>for that matter - v8 and later had thrown that crap away).

ioctl()s do introduce a common abstract interface layer.

Tell me how else you would like to set similar things in e.g. different disk 
type drivers.

In Plan 9, they did replace them with a text interface to /dev/{driver}.ctl

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
