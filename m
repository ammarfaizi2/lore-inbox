Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVHHQvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVHHQvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVHHQvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:51:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24551 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932114AbVHHQvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:51:15 -0400
Date: Mon, 8 Aug 2005 18:51:14 +0200
From: Andi Kleen <ak@suse.de>
To: Tim Hockin <thockin@hockin.org>
Cc: Andi Kleen <ak@suse.de>, Erick Turnquist <jhujhiti@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Message-ID: <20050808165114.GM19170@wotan.suse.de>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel> <p73mznuc732.fsf@bragg.suse.de> <20050807174811.GA31006@hockin.org> <20050808120125.GD19170@wotan.suse.de> <20050808164754.GA26031@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808164754.GA26031@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 09:47:54AM -0700, Tim Hockin wrote:
> On Mon, Aug 08, 2005 at 02:01:25PM +0200, Andi Kleen wrote:
> > > Some BIOSes do not lock SMM, and you *could* turn it off at the chipset
> > > level.
> > 
> > Doing so would be wasteful though. Both AMD and Intel CPUs need SMM code
> > for the deeper C* sleep states.
> 
> Really?  I'm not too familiar with the deeper C states - what role does
> SMM play?

It does all the hard work of powering down and up the CPU in C2 and C3. On 
AMD K8 even C1 (=HLT) executes SMM code depending on the BIOS setup.

-Andi
