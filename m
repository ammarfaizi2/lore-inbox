Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUAGGvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUAGGvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:51:04 -0500
Received: from colin2.muc.de ([193.149.48.15]:18180 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266144AbUAGGvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:51:02 -0500
Date: 7 Jan 2004 07:51:56 +0100
Date: Wed, 7 Jan 2004 07:51:56 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Adam Belay <ambx1@neo.rr.com>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040107065156.GA30773@colin2.muc.de>
References: <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com> <Pine.LNX.4.58.0401062000490.12602@home.osdl.org> <20040107050256.GA4351@colin2.muc.de> <20040107055557.GA13812@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107055557.GA13812@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:55:57AM +0000, Dave Jones wrote:
> On Wed, Jan 07, 2004 at 06:02:56AM +0100, Andi Kleen wrote:
>  > > > 5.) Look into other ways of finding out if the PnPBIOS might be buggy,
>  > > > currently we only have DMI.
>  > > > Any others?
>  > > We could use the exception mechanism, and try to fix up any BIOS errors. 
>  > > That would require:
>  > 
>  > [...] It would not work for x86-64 unfortunately where you cannot do 
>  > any BIOS calls after the system is running (it would only be possible
>  > early in boot) 
> 
> Why on earth would you want to call PNPBIOS on AMD64 anyway ?

See the preceding thread. We're currently missing a reliable way to find
free IO space for PCI resources, which is needed for some cases. The
PNPBIOS was discussed as one of the possible solutions.

For AMD64 clearly something ACPI based is needed though.

-Andi
