Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRKYLnT>; Sun, 25 Nov 2001 06:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280832AbRKYLnB>; Sun, 25 Nov 2001 06:43:01 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:31503 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S280838AbRKYLmr>; Sun, 25 Nov 2001 06:42:47 -0500
Date: Sun, 25 Nov 2001 22:42:59 +1100
From: john slee <indigoid@higherplane.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Network hardware: "Network Media Detection"
Message-ID: <20011125224259.A4844@higherplane.net>
In-Reply-To: <E167ja2-0004fF-00@carbon.btinternet.com> <9tpiio$n4u$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9tpiio$n4u$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 05:47:04PM -0800, H. Peter Anvin wrote:
> > Hi
> > I was wondering if there was any way in linux to use what redmond calls 
> > "Network Media Detection"?
> This is basically taking the interface down when the link disappears
> (and vice versa.)  Rather useful for portable systems.  Don't think
> anyone has implemented it, but it should be easy enough to do.

is there a common field in net_device{} for link state (not just up or
down, but media type too)?

all the various ethernet drivers seem to handle link changes rather
differently.  being able to notify userspace of media changes in a
not-driver-specific manner would be nice as links flapping from 10 to
100Mbps and back often means problems are afoot.

also i am undecided on _how_ to tell userspace about it...  the current
hotplug system only seems to handle plug/unplug, whereas this is a
device state change and as such doesn't really fit the mould...

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
