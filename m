Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbULUGAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbULUGAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 01:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULUGAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 01:00:09 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:62357 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261299AbULUF74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 00:59:56 -0500
References: <20041221024347.3004.qmail@web52606.mail.yahoo.com>
Message-ID: <cone.1103608791.326982.28853.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: jesse <jessezx@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gurus, a silly question for preemptive behavior
Date: Tue, 21 Dec 2004 16:59:51 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jesse writes:

>  
> As i know, in linux, user space application is
> preemptive at any time. however, linux kernel is NOT
> preemptive, that means, even some event is finished,
> Linux kernel scheduler itself still can't have
> opportunity to interrupt the current user application
> and switch it out. it is called scheduler latency.

The kernel is preemptible if you enable the preempt option in the 
configuration. There are some code paths that are not preemptible despite 
this, but they are gradually being improved over time.

> normally , the latency is about 88us in mean , maximum
> : 200ms. Thus, the short latency shouldn't impact user
> applications too much and is not a problem. It is an
> issue in those embedded voice processing systems by
> introducing jitters, thus smart people came up with
> two kernel schedule patch: preemptive patch and low
> latency patch. 

You're thinking about the 2.4 kernel. 2.6 is effectively both of those 
patches inclusive.

> my system: 
> [root@sa-c2-7 proc]# uname  -a 
> Linux sa-c2-7 2.4.21-15.ELsmp #1 SMP Thu Apr 22
> 00:18:24 EDT 2004 i686 i686 i386 GNU/Linux 

If you want lower latency on a 2.4 kernel you need further patches. You are 
most likely to benefit from a move to a 2.6 kernel and enabling preempt.

Cheers,
Con

