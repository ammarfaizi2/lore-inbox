Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWCFPua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWCFPua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWCFPu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:50:29 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:47632 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751204AbWCFPu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:50:29 -0500
Date: Mon, 6 Mar 2006 16:50:21 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Is that an acceptable interface change?
Message-ID: <20060306155021.GA23513@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20060306011757.GA21649@dspnet.fr.eu.org> <1141631568.4084.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141631568.4084.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 08:52:48AM +0100, Arjan van de Ven wrote:
> On Mon, 2006-03-06 at 02:17 +0100, Olivier Galibert wrote:
> > I'm looking at the changes in the asound.h file, and especially at
> > commit 512bbd6a85230f16389f0dd51925472e72fc8a91, and I've been
> > wondering if it's acceptable compatibility-wise.  All the structures
> > passed through ioctl (and ALSA is 100% ioctl) have been renamed from
> > sndrv_* to snd_*.  That breaks source compatibility but not binary
> > compatibility.
> 
> only if you are "stupid" enough to use kernel headers in your userspace!
> Which you shouldn't do normally

Does that mean it is the responsability of whoever packages the
headers for userspace consumption to rename the structs back?  Or that
every application should come with its own copy of the kernel headers
it may need and be ready for massive source-level breakage when
rebasing?

I'm just trying to understand if we care about source compatibility
for userspace or not.

  OG.
