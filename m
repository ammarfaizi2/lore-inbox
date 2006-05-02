Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWEBHFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWEBHFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWEBHFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:05:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:64985 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932425AbWEBHFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:05:34 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Date: Tue, 2 May 2006 09:05:28 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu>
In-Reply-To: <20060502070618.GA10749@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605020905.29400.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 09:06, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Ingo Molnar <mingo@elte.hu> writes:
> > 
> > > FYI, even on 2.6.17-rc3 i get the one below. v2.6.17 showstopper i 
> > > guess?
> > 
> > Did you send a full boot log?
> 
> yes, in the previous mail, in the same thread. (maybe lkml ate it - it's 
> an allyesconfig bootup so a large bootlog and a large config) I've also 
> uploaded them to:
> 
> 	http://redhat.com/~mingo/misc/
> 
> debug-pagealloc.patch is the debug patch i made based on Nick's earlier 
> suggestions.
> 
> > If it's using ACPI NUMA try numa=noacpi - it might be some problem 
> > with the node discovery on your machine.
> 
> this is a non-NUMA box (Athlon64 X2 desktop machine).

Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
anywhere but some Summit systems (at least every time I tried it it blew up 
on me and nobody seems to use it regularly). Maybe it would be finally time to mark it 
CONFIG_BROKEN though or just remove it (even by design it doesn't work very well) 

If you want NUMA use 64bit.

-Andi
