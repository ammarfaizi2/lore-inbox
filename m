Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbUAGFCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 00:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUAGFCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 00:02:04 -0500
Received: from colin2.muc.de ([193.149.48.15]:19729 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266074AbUAGFCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 00:02:02 -0500
Date: 7 Jan 2004 06:02:56 +0100
Date: Wed, 7 Jan 2004 06:02:56 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adam Belay <ambx1@neo.rr.com>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040107050256.GA4351@colin2.muc.de>
References: <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com> <Pine.LNX.4.58.0401062000490.12602@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401062000490.12602@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 08:06:42PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 6 Jan 2004, Adam Belay wrote:
> >
> > 5.) Look into other ways of finding out if the PnPBIOS might be buggy,
> > currently we only have DMI.
> > 
> > Any others?
> 
> We could use the exception mechanism, and try to fix up any BIOS errors. 
> That would require:

[...] It would not work for x86-64 unfortunately where you cannot do 
any BIOS calls after the system is running (it would only be possible
early in boot) 

My hope was actually that there is some ACPI mechanism to do all this,
but I haven't done much research in this area yet.

-Andi
