Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWEQSGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWEQSGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWEQSGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:06:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:34503 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750834AbWEQSGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:06:05 -0400
From: Andi Kleen <ak@suse.de>
To: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC] [Patch 0/8] statistics infrastructure
Date: Wed, 17 May 2006 20:05:43 +0200
User-Agent: KMail/1.9.1
Cc: Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       James.Smart@emulex.com, James.Bottomley@steeleye.com,
       ltt-dev@shafik.org
References: <446A0F77.70202@de.ibm.com> <y0msln8wooo.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0msln8wooo.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605172005.44588.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 19:23, Frank Ch. Eigler wrote:
> 
> Martin Peschke <mp3@de.ibm.com> writes:
> 
> > My patch series is a proposal for a generic implementation of statistics.
> > Envisioned exploiters include device drivers, and any other component.
> > [...]
> > Good places to start reading code are:
> >    statistic_create(), statistic_remove()
> >    statistic_add(), statistic_inc()
> > [...]
> 
> It is interesting how many solutions pop up for this sort of problem.
> The many tracing tools/patches, systemtap, and now this, all share
> some goals and should ideally share some of the technology.

I disagree. They often have very different requirements - and a one-size-fits-all
solution will be likely too heavyweight for most users.

The passing to user space can be unified, but we already have solutions
for that (seq_*, relayfs). But the actual data gathering is better custom
tailored.

-Andi
