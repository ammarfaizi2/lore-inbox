Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTIDThc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTIDThS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:37:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:46494 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262071AbTIDThM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:37:12 -0400
Date: Thu, 4 Sep 2003 12:34:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
cc: <maverick@eskuel.com>, <felipe_alfaro@linuxmail.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: Power Management Update
In-Reply-To: <20030904093414.GA25219@lps.ens.fr>
Message-ID: <Pine.LNX.4.33.0309041035120.940-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is boggling. 

> standby/S1 or mem/S3 make the kernel oops and hangs. Call strace:
> 	enter_state
> 	suspend_prepare
> 	enter_state

Is there anyway that you remember what the Oops was (i.e. the few lines 
above the back trace)? 

Also, could you please confirm that you're using 2.6.0-test4 + the PM
patches I posted last Saturday + the patch I posted yesterday? I trust
that you are, however I cannot reproduce the Oops at all. 

The Oops looks the one that was present in -test4 initially, but why 
you're able to at least begin a suspend-to-disk transition doesn't make 
sense. 

> Before the patch, S1 and S3 would have the screen blink and computer
> immediately resume to normal operation. Sometimes, S1 would actually
> standby (screen lit and hard disk spinning, though) waiting for a
> keypress.

Based on your dmesg here: 

http://perso.nerim.net/~tudia/bug-reports/2.6.0-pre4-pm

Your system does not support S3, so returning immediately would be the 
proper thing to do. I will continue to investigate. 

Thanks for testing,


	Pat

