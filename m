Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSAFN25>; Sun, 6 Jan 2002 08:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSAFN2r>; Sun, 6 Jan 2002 08:28:47 -0500
Received: from holomorphy.com ([216.36.33.161]:32457 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288948AbSAFN2f>;
	Sun, 6 Jan 2002 08:28:35 -0500
Date: Sun, 6 Jan 2002 05:28:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@suse.de>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020106052815.F10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@suse.de>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020106123913.GA5407@krispykreme> <Pine.LNX.4.33.0201061403120.3859-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0201061403120.3859-100000@Appserv.suse.de>; from davej@suse.de on Sun, Jan 06, 2002 at 02:07:05PM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Anton Blanchard wrote:
>> Therefore there is no reason to waste 8 bytes per page when every page
>> points to the same zone!

On Sun, Jan 06, 2002 at 02:07:05PM +0100, Dave Jones wrote:
> Some of the low end single zone machines (m68k, sparc32, arm etc)
> could benefit from losing ->virtual too. wli has patches in
> his dir on kernel.org that do this (and other struct page reductions)
> The newer ones are against Rik's rmap vm though iirc, so you may have to
> frob a bit to get them to play with the stock vm.

I can personally (and quite quickly) port the page size reductions to
other VM's, as the changes required are not particularly invasive.

On Sun, Jan 06, 2002 at 02:07:05PM +0100, Dave Jones wrote:
> It'd be nice to see all these patches reducing this struct consolidated,
> right now they're all ifdefing different bits with different names..

I can correct style issues and the like for at least the bits I'm
responsible for  in very short order. I'll consolidate the waitqueue,
->virtual and ->zone removals within the hour, since that appears to
be wanted/needed.

Anton, do you want to take on mixing the zone into ->flags folding with
your approach?

Cheers,
Bill
