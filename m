Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUEDAOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUEDAOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUEDAOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:14:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64945 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264061AbUEDAOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:14:53 -0400
Date: Tue, 4 May 2004 01:14:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       davidm@hpl.hp.com, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040504001450.GK17014@parcelfarce.linux.theplanet.co.uk>
References: <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <20040503140251.274e1239.akpm@osdl.org> <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk> <20040503212450.GC31580@wohnheim.fh-wedel.de> <20040503215434.GI17014@parcelfarce.linux.theplanet.co.uk> <20040503223317.GD31580@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503223317.GD31580@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 12:33:17AM +0200, Jörn Engel wrote:
> That cannot be all.  What about these two?  Not sure if my patch is
> correct or it should rather s/O_RDONLY/FMODE_READ/.

WTF does that have to sys_open(9) or open(9)?

And no, dentry_open() does not take FMODE_... - open_namei() does,
but dentry_open() takes flags unchanged.  Just take a look at
fs/open.c::filp_open() - flags are passed unchanged.
