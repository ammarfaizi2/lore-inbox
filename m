Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTIWTfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTIWTfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:35:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52188 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263496AbTIWTfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:35:00 -0400
Date: Tue, 23 Sep 2003 12:22:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: schwab@suse.de, bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923122200.258215a3.davem@redhat.com>
In-Reply-To: <20030923192804.GG13172@parcelfarce.linux.theplanet.co.uk>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<jehe3372th.fsf@sykes.suse.de>
	<20030923115200.1f5b44df.davem@redhat.com>
	<20030923192804.GG13172@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 20:28:04 +0100
Matthew Wilcox <willy@debian.org> wrote:

> That's not true; they could be avoided by using get_unaligned() and
> put_unaligned().  You just don't want to because they'd make sparc suck.

Not only sparc would be effected by this.  Using {get,put}_unaligned()
all over the networking would incur a penalty for many platforms, not
just sparc.

