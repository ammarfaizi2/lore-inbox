Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316096AbSENW3T>; Tue, 14 May 2002 18:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316097AbSENW3S>; Tue, 14 May 2002 18:29:18 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:7591 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316096AbSENW3R>; Tue, 14 May 2002 18:29:17 -0400
Date: Tue, 14 May 2002 23:44:45 +0200
From: Andi Kleen <ak@muc.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020514234445.A4226@averell>
In-Reply-To: <3CD9E8A7.D524671D@zip.com.au> <5.1.0.14.2.20020509193347.02ff6dc8@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <m31yck9700.fsf@averell.firstfloor.org> <3CDB18CF.82DD6D6B@zip.com.au> <20020510030645.A2922@averell> <20020513175059.B37@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 07:51:00PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The tricky bit is to avoid prefetches over the boundary of your copy.
> > Prefetching from an uncached area or write combined area (like the 
> > AGP gart which could start in next page) triggers hardware bugs in
> > various boxes. This unfortunately complicates the prefetching loops
> > a bit.
> 
> CONFIG_MY_MACHINE_AINT_BORKEN? We definitely could assume that on x86-64.

I was advised by AMD that I should better avoid it even for future boxes.

-Andi
