Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271307AbTHRHEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 03:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271298AbTHRHEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 03:04:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45323 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271295AbTHRHEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 03:04:06 -0400
Date: Mon, 18 Aug 2003 08:56:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030818065652.GA15098@alpha.home.local>
References: <200308171516090038.0043F977@192.168.128.16> <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk> <200308171555280781.0067FB36@192.168.128.16> <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk> <200308171759540391.00AA8CAB@192.168.128.16> <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk> <200308171827130739.00C3905F@192.168.128.16> <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk> <20030817224849.GB734@alpha.home.local> <20030817222258.257694b9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817222258.257694b9.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Sun, Aug 17, 2003 at 10:22:58PM -0700, David S. Miller wrote:
> On Mon, 18 Aug 2003 00:48:49 +0200
> Willy Tarreau <willy@w.ods.org> wrote:
> 
> > I have a case where this doesn't work
> 
> And that's exactly what arpfilter is for.

That's indeed what I was supposing so.

> There are zero performance implications from using
> arpfilter too, if that is something people are worried
> about.

I'm not worried about performance, which I can easily imagine is not affected
for such rare events as ARP requests.

I'm more worried about how to set it up. I have already searched in
Documentation/networking, on google, etc... but didn't find any useful
information about how to set up an arpfilter configuration. I'd agree to test
it, but don't know where to start from. I even don't know if it's related to
'ip arp'. I guess that's what stops most people from using it. Others may even
not be aware that this feature exists at all.

Other than that, I don't know if the resulting configuration will still be
straightforward or look completely tricky.

Again, I don't know what we can break by applying the arp_prefsrc patch, which
will do the Right Thing most of the time. And when it won't, the current code
would also have required arpfilter anyway.

But I'm willing to try arpfilter if you show me where to start from.

Cheers,
Willy

