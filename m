Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWIYCSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWIYCSK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWIYCSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:18:10 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:65163 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964812AbWIYCSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:18:09 -0400
From: Junio C Hamano <junkio@cox.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       junkio@cox.net
Subject: Re: git diff <-> diffstat
References: <20060924161809.GA13423@havoc.gtf.org>
	<Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
	<45172297.6070108@garzik.org>
	<Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
	<20060925011436.GC4547@stusta.de>
Date: Sun, 24 Sep 2006 19:18:07 -0700
In-Reply-To: <20060925011436.GC4547@stusta.de> (Adrian Bunk's message of "Mon,
	25 Sep 2006 03:14:36 +0200")
Message-ID: <7v7izs7kps.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> Is there any way for "git diff" to handle additional options diffstat 
> handles? I'm a big fan of the -w72 diffstat option.

No, but patches are welcome ;-).

> Oh, and with git 1.4.2.1,
>   git diff -M --stat --summary v2.6.18..master
> in your tree gives me some funny lines like:
>
>  .../netlabel/draft-ietf-cipso-ipsecurity-01.txt    |  791 +
>  .../{cpu_setup_power4.S => cpu_setup_ppc970.S}     |  103 
>  .../powerpc/platforms}/iseries/it_exp_vpd_panel.h  |    6 
>  .../powerpc/platforms}/iseries/it_lp_naca.h        |    6 
>
> I don't know what's going wrong here, but diffstat doesn't produce this.

Of course diffstat does not know how to grok -M and it would not
note renames.

