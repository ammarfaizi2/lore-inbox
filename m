Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUCQWZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUCQWZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:25:36 -0500
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:1490 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S262110AbUCQWZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:25:21 -0500
Date: Wed, 17 Mar 2004 17:27:50 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Marek Szuba <scriptkiddie@wp.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4, or what I still don't quite like about the new stable
 branch
In-Reply-To: <4058097F.4070606@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0403171709000.4288@dust.p68.rivermarket.wintek.com>
References: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
 <Pine.LNX.4.58.0403131642270.4325@dust.p68.rivermarket.wintek.com>
 <4058097F.4070606@aitel.hist.no>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Helge Hafting wrote:

> Alex Goddard wrote:
> [...]
> > 
> > Safe module unloading is a very difficult problem.  So much so that
> > disallowing unloading modules completely has been discussed in the past.  
> > Digging around an lkml archive for more info on why module unloading is
> > inherently problematic, and not at all easy to do (well, not at all easy
> > to do well) is recommended.
> 
> Safe unloading is hard for a few oddball modules that probably shouldn't
> be modules at all but rather be part of some larger module.  Is it necessary
> to have modules for various parts of iptables, instead of stuffing 
> everything in a big "ipv4" module?

That is not the impression I got from this post:  
http://marc.theaimsgroup.com/?l=linux-kernel&m=104554480315013&w=2

This thread is the other one that came to mind:  
http://marc.theaimsgroup.com/?l=linux-kernel&m=105915495603446&w=2

In one post in the thread spawned by the second URL's post, Alan Cox
suggests a plan vaguely similar to what you outlined below what I've
quoted (ie: a MODULE_UNLOADABLE flag or something for those modules that
_can_ be easily unloaded).

However, the general impression I get from that thread on removing module
refcounting is that in general unloading modules is tricky.  Not
unsolvable.  Just tricky.

-- 
Alex Goddard
agoddard at purdue dot edu
