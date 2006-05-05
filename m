Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWEES1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWEES1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 14:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEES1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 14:27:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:27790 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751171AbWEES1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 14:27:36 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
Date: Fri, 5 May 2006 20:27:21 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <445B7EF0.6090708@zytor.com> <p733bfo5ol1.fsf@bragg.suse.de> <445B96E1.3080401@zytor.com>
In-Reply-To: <445B96E1.3080401@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605052027.21985.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 20:18, H. Peter Anvin wrote:
> Andi Kleen wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > 
> >> The recent fix for the AMD FXSAVE information leak had a problematic
> >> side effect.  It introduced an entry in the x86 features vector which
> >> is a bug, not a feature.
> > 
> > It's a non issue because it affects all AMD CPUs (except K5/K6).
> > You'll never find a system where only some CPUs have this problem.
> > 
> 
> It's still wrong architecturally, and we should have a sane way to deal with this as well 
> as other bugs.  This isn't the only bug -- we're getting a decent-size collection of them 
> already -- and not all of them is going to have that particular property.

I'm not very worried because mixing steppings is generally unsupported anyways
and in Linux also doesn't work well with it.

(e.g. my old rig with one CPU FXSAVE capable, one CPU not never worked without
kernel hacks) 

It's probably not worth the effort anyways. The people who build such strange
systems can tweak their kernels for it too.

-Andi
