Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267223AbSLEFHg>; Thu, 5 Dec 2002 00:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbSLEFHg>; Thu, 5 Dec 2002 00:07:36 -0500
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:37104 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S267223AbSLEFHf>; Thu, 5 Dec 2002 00:07:35 -0500
Date: Wed, 4 Dec 2002 21:15:07 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Orion Poplawski <orion@cora.nwra.com>
Cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS - IRIX client issues
Message-ID: <20021205051507.GA17498@ip68-4-86-174.oc.oc.cox.net>
References: <3DEE85D3.6070009@cora.nwra.com> <3DEE8EC2.2040305@rackable.com> <3DEE9425.40204@cora.nwra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEE9425.40204@cora.nwra.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 04:47:49PM -0700, Orion Poplawski wrote:
> The mount comes up fine and works for quite a while and then crashes. 
> This is under relatively heavy load (tar files being unpacked, data 
> files manipulated, etc.).  No iptables/chains.

I'm having the same problem, with Solaris 8 on SPARC for the NFS server
(as opposed to Linux), on one of my machines. For some reason it only
happens when it's plugged into a 100MBps Netgear non-switching (i.e, "old
fashioned" in a sense -- half-duplex) hub. If I plug it straight into
the wall at work (this is connected directly to a 10MBps (I know),
full-duplex (I think) port on some kind of switch whose other details I
have no idea about), the problem instantly disappears.

At least, I think it's the same problem. When your connection collapses,
does IRIX complain about timeouts trying to contact the NFS server,
almost as if the NFS server fell off the face of the planet?

I just noticed this patch (4808: "NFS3 hangs with delayed writes, panics
with imon") for IRIX 6.5.17m. The following page has more detail
(although just reading the following page, as well as downloading the
actual patch, requires an SGI support contract or warranty -- and I can't
look at it and summarize it because TPTB at work have canceled the SGI
support contracts with the intent of eventually replacing all the SGI
boxes with Linux-based x86's or the like):
http://support.sgi.com/colls/patches/docs/browse/support/pinfo/pinfo4808.html

So, that patch might help, if you have access to it. I also found
another document, "Pipeline: [Oct-Dec 2002] IRIX 6.5.17 NFS Changes and
Tuning", which also cannot be accessed without a support contract or
warranty:
http://support.sgi.com/search/?cmd=getdoc&db=pipeline&locale=C&coll=0650&highlight=type,pipeline,PipelineYear,2002,PipelineIssue,OctoberDecember&fname=content/pipeline/html/20020402NFS.html

Finally, I have no idea if IRIX 6.5.18m fixes any NFS bugs. If it does,
it can be obtained with an M Series Access contract that costs $500 per
workstation per year (servers not eligible, that is, they can only get
6.5.18m through support contracts AFAIK). A tiny bit more info on that
here:
http://support.sgi.com/news/support/IRIX_M_Stream_Implementation.html
http://support.sgi.com/news/support/IRIX_M_Stream_Implementation1.html

I hope this helps. It might not help as much as other suggestions (such
as trying NFSv2), but it might be better than nothing (especially if the
machine is still covered by an SGI support contract or warranty).

-Barry K. Nathan <barryn@pobox.com>
