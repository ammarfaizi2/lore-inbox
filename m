Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUA1W7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266039AbUA1W7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:59:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:6588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265834AbUA1W7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:59:18 -0500
Date: Wed, 28 Jan 2004 14:59:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <20040128233948.26a36ff7.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0401281458000.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
 <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401281129570.28145@home.osdl.org> <20040128204049.627e6312.ak@suse.de>
 <Pine.LNX.4.58.0401281205250.28145@home.osdl.org> <20040128211554.0cc890fb.ak@suse.de>
 <Pine.LNX.4.58.0401281221320.28145@home.osdl.org> <20040128220921.7ba0bb78.ak@suse.de>
 <Pine.LNX.4.58.0401281340301.28145@home.osdl.org> <20040128225205.02193769.ak@suse.de>
 <Pine.LNX.4.58.0401281420430.28145@home.osdl.org> <20040128233948.26a36ff7.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Andi Kleen wrote:
> > Doing a status read from the device should do it (just read the config 
> > space, for example).
> 
> The device is just not known. iirc you only get a bit in the bridge, which
> leaves a wide choice.

read_pcix_error() _does_ know the device. The driver tells it.

Remember: none of this should be done at machine check time. 

		Linus
