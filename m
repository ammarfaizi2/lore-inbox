Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVKIXaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVKIXaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVKIXaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:30:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:43786 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751001AbVKIX3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:29:51 -0500
Date: Thu, 10 Nov 2005 00:11:23 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-rc3
Message-ID: <20051109231123.GA18858@alpha.home.local>
References: <20051109133216.GA9183@logos.cnet> <20051109185223.GA4047@stusta.de> <20051109141530.GA9332@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109141530.GA9332@logos.cnet>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian, hi Marcelo,

On Wed, Nov 09, 2005 at 12:15:31PM -0200, Marcelo Tosatti wrote:
(...)
> > If there will be one more -rc, could you include my airo_cs fix?
> 
> Hi Adrian,
> 
> I think it can wait for the next -pre... Hope there wont be another -rc.

So do I. Moreover, -pre should start with several network-related fixes,
so your fix might find a comfortable place there :-)

I will release another -hf with recent fixes. I noticed I missed three of
them from 2.4.32-rc2 (I thought I was up to date but they showed up just
before the announcement). They are the memleak in sd_mod, the TCP snd_wnd
fix and the fix for the infinite loop in udp_v6_get_port(). So I can also
merge your fix early if you want (I already queued it for later inclusion).
I generally try to avoid including fixes that are not much transversal,
but I read in your patch that the bug you fixed could cause side effects
to any parts in the kernel, so if you feel it's appropriate for -hf, I'll
trust you :-)

Cheers,
Willy

