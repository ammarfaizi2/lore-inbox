Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbUKCWsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUKCWsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUKCWoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:44:54 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:39041 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261952AbUKCWlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:41:40 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Jim Nelson <james4765@verizon.net>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 17:44:58 -0500
User-Agent: KMail/1.7
Cc: DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD> <4189586E.2070409@verizon.net>
In-Reply-To: <4189586E.2070409@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031644.58979.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 16:15, Jim Nelson wrote:

> I did this to myself a number of times when I was first learning Samba -
> even an ls would become unkillable.  You couldn't rmmod smb, since it was
> in use, and you couldn't kill the process, since it was waiting on a
> syscall.  Ergh.
>

I'm not going to pretend to be a kernel expert, or really anything other than 
a newbie when it comes to kernel internals, so please take this with the 
merits it deserves - many, or none, depending.

Anyway, is there a way to simply signal a syscall that it is to be interrupted 
and forcibly cause the syscall to end?  Kicking the program execution out of 
kernel space would be sufficient to "unstick" the process - and coupling that 
with an automatic KILL signal may not be a bad idea.

I'm pretty sure that someone will think of a way why this wouldn't work with 
very little effort.  Please enlighten me?

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
