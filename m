Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030640AbWJJXcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030640AbWJJXcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWJJXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:32:18 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:33424 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1030680AbWJJXcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:32:16 -0400
Date: Wed, 11 Oct 2006 01:32:14 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Paul Wouters <paul@xelerance.com>
Cc: fedora-xen@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more random device badness in 2.6.18 :(
Message-ID: <20061010233214.GA20863@boogie.lpds.sztaki.hu>
References: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com> <20061010205051.GB14865@boogie.lpds.sztaki.hu> <Pine.LNX.4.63.0610102257100.27986@tla.xelerance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610102257100.27986@tla.xelerance.com>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 11:03:58PM +0200, Paul Wouters wrote:

> Why is this happening in userland?

Because whether the provided data is "random enough" is a policy
decision, and policy does not belong in the kernel.

> Will rng-tools run on every bare Linux
> system now? Including embedded systems?

Why not? Alternatively you can always create your own version. Open
source does not mean you get everything for free; it means you _can_ do
the work if you want to.

> How about xen guests who don't have
> direct access to the host's hardware (or software) random?

If they don't have access to the host's hardware, then they do not have a
/dev/hw_random device. What's your question? And how that's different
from machines not having a hw rng at all?

> Why is this entropy management not part of the kernel? So for Openswan to
> work correctly, it would need to depend on another daemon that may or may
> not be available and/or running?

No. It only has to depend on /dev/(u)random. How the entropy is obtained
(from /dev/hw_random, from the soundcard's white noise or from
elsewhere) is none of Openswan's business.  Tha'ts up to the system
administrator or distribution maker to decide and set up.

> I still believe /dev/random should just give the best random possible for
> the machine. Wether that is software random, or a piece of hardware, should
> not matter. That's the kernel's internal state and functioning.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
