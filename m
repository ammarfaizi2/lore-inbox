Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUD0U2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUD0U2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbUD0U2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:28:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264330AbUD0U2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:28:14 -0400
Date: Tue, 27 Apr 2004 21:28:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
Message-ID: <20040427202813.GA17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net> <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org> <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com> <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net> <20040427140533.GI14129@stingr.net> <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk> <20040427200459.GJ14129@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427200459.GJ14129@stingr.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 12:04:59AM +0400, Paul P Komkoff Jr wrote:
> > Excuse me?  The damn thing had found nothing.  However, it didn't care
> > to release the devices it had claimed - hadn't even closed them, as the
> > matter of fact.  That's a clear and obvious bug, regardless of any
> > disagreements.
> 
> As far as I can see from here, evms parsed partition table, called
> dmsetup several times and created corresponding nodes in /dev/evms.

... without saying anything?

> Logic is easy - evms trying to concentrate block device management
> into its own hands, but we have in-kernel partitioning code to
> consider ...

How nice of them.

Well, AFAICS that means
	a) either kernel side of the things or the userland tools should
printk/syslog - at least that evms device had been set up
	b) any distribution that runs this from initrd/init scripts would
better take care of having sane fstab.
	c) nobody sane should put that as default.  Oh, wait, it's gentoo
we are talking about?  Nevermind, then.
