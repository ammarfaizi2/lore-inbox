Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVFNXUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFNXUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVFNXUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:20:25 -0400
Received: from mail.suse.de ([195.135.220.2]:11656 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261416AbVFNXTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:19:12 -0400
Date: Wed, 15 Jun 2005 01:19:11 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, christoph <christoph@scalex86.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-ID: <20050614231911.GV11898@wotan.suse.de>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de> <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614230411.GU11898@wotan.suse.de> <Pine.LNX.4.62.0506141614570.23117@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506141614570.23117@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 04:17:14PM -0700, Christoph Lameter wrote:
> On Wed, 15 Jun 2005, Andi Kleen wrote:
> 
> > > Hmm. No. The bigger cpu maps may benefit from cacheline alignment for 
> > > even for read access. 
> > 
> > Why? Can you please explain that. It doesn't make sense to me.
> 
> Its more likely to get a big piece of the array in a single 
> cacheline if the array starts at the beginning of a cacheline.
> 
> If these maps would start in the middle of a cacheline then additional 
> cacheline fetches may become necessary to scan an array etc.

But the CPUs do prefetching anyways for that. Do you have numbers
that this is actually worth it? 

-Andi
