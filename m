Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUH2X0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUH2X0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268399AbUH2X0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:26:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268392AbUH2X0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:26:00 -0400
Date: Mon, 30 Aug 2004 00:25:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@osdl.org>, Hans Reiser <reiser@namesys.com>,
       flx@msu.ru, Paul Jackson <pj@sgi.com>, riel@redhat.com,
       ninja@slaphack.com, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, Andrew Morton <akpm@osdl.org>,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829232556.GB16297@parcelfarce.linux.theplanet.co.uk>
References: <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com> <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <1093821430.8099.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1093821430.8099.49.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 07:17:10PM -0400, Trond Myklebust wrote:
> På su , 29/08/2004 klokka 17:50, skreiv Linus Torvalds:
> > The general VFS layer has a lot of rules, and avoids these problems by
> > simply never having aliases between two directories. If the same directory
> > shows up multiple times (which can happen with bind mounts), they have the
> > exact same dentry for the directory, it's just found through two different
> > vfsmount instances. That's why vfsmounts exist - they allow the same name
> > cache entry to show up in different places at the same time.
> 
> So could you explain what is stopping us from reducing the whole problem
> to the bind mount problem? IOW have "a/" be a directory that acts as if
> it is dynamically bind mounted on top of the file "a".
> 
> 
> Is it just the fantasy of supporting hard-links across "stream
> boundaries" (as in "touch a b; ln b a/b; ln a b/a")? I'm pretty sure
> nobody wants to have to add cyclic graph detection to their filesystems
> anyway. 8-)
> 
> What other issues would need to be addressed?

Go upthread and read.
