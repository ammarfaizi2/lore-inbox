Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268388AbUH2XSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268388AbUH2XSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268387AbUH2XSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:18:38 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:27029 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S268383AbUH2XSe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:18:34 -0400
Subject: Re: silent semantic changes with reiser4
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Hans Reiser <reiser@namesys.com>, flx@msu.ru, Paul Jackson <pj@sgi.com>,
       riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
	 <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
	 <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com>
	 <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
	 <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
	 <41323751.5000607@namesys.com>
	 <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1093821430.8099.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 19:17:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 29/08/2004 klokka 17:50, skreiv Linus Torvalds:
> The general VFS layer has a lot of rules, and avoids these problems by
> simply never having aliases between two directories. If the same directory
> shows up multiple times (which can happen with bind mounts), they have the
> exact same dentry for the directory, it's just found through two different
> vfsmount instances. That's why vfsmounts exist - they allow the same name
> cache entry to show up in different places at the same time.

So could you explain what is stopping us from reducing the whole problem
to the bind mount problem? IOW have "a/" be a directory that acts as if
it is dynamically bind mounted on top of the file "a".


Is it just the fantasy of supporting hard-links across "stream
boundaries" (as in "touch a b; ln b a/b; ln a b/a")? I'm pretty sure
nobody wants to have to add cyclic graph detection to their filesystems
anyway. 8-)

What other issues would need to be addressed?

Cheers,
  Trond
