Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVCBJIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVCBJIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVCBJIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:08:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:5550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262233AbVCBJIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:08:43 -0500
Date: Wed, 2 Mar 2005 01:06:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: kaigai@ak.jp.nec.com, johnpol@2ka.mipt.ru, hadi@cyberus.ca, tgraf@suug.ch,
       marcelo.tosatti@cyclades.com, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050302010614.2a8bb483.akpm@osdl.org>
In-Reply-To: <1109753893.8422.127.camel@frecb000711.frec.bull.fr>
References: <4221E548.4000008@ak.jp.nec.com>
	<20050227140355.GA23055@logos.cnet>
	<42227AEA.6050002@ak.jp.nec.com>
	<1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	<20050227233943.6cb89226.akpm@osdl.org>
	<1109592658.2188.924.camel@jzny.localdomain>
	<20050228132051.GO31837@postel.suug.ch>
	<1109598010.2188.994.camel@jzny.localdomain>
	<20050228135307.GP31837@postel.suug.ch>
	<1109599803.2188.1014.camel@jzny.localdomain>
	<20050228142551.GQ31837@postel.suug.ch>
	<1109604693.1072.8.camel@jzny.localdomain>
	<20050228191759.6f7b656e@zanzibar.2ka.mipt.ru>
	<1109665299.8594.55.camel@frecb000711.frec.bull.fr>
	<42247051.7070303@ak.jp.nec.com>
	<1109753893.8422.127.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
>   So I ran the lmbench with three different kernels with the fork
>  connector patch I just sent. Results are attached at the end of the mail
>  and there are three different lines which are:
> 
>  	o First line is  a linux-2.6.11-rc4-mm1-cnfork
>  	o Second line is a linux-2.6.11-rc4-mm1
>  	o Third line is  a linux-2.6.11-rc4-mm1-cnfork with a user space
>            application. The user space application listened during 15h 
>            and received 6496 messages.
> 
>  Each test has been ran only once. 
> 
> ...
>  ------------------------------------------------------------------------------
>  Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
>                               call  I/O stat clos TCP  inst hndl proc proc proc
>  --------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
>  account   Linux 2.6.11- 2765 0.17 0.26 3.57 4.19 16.9 0.51 2.31 162. 629. 2415
>  account   Linux 2.6.11- 2765 0.16 0.26 3.56 4.17 17.6 0.50 2.30 163. 628. 2417
>  account   Linux 2.6.11- 2765 0.16 0.27 3.67 4.25 17.6 0.51 2.28 176. 664. 2456

This is the interesting bit, yes?  5-10% slowdown on fork is expected, but
why was exec slower?

What does "The user space application listened during 15h" mean?
