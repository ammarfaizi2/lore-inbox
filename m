Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUG0PWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUG0PWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266381AbUG0PWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:22:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:15768 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265429AbUG0PWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:22:43 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Date: Tue, 27 Jul 2004 08:15:39 -0700
User-Agent: KMail/1.6.2
Cc: colpatch@us.ibm.com, jbarnes@sgi.com, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net
References: <1090887007.16676.18.camel@arrakis> <20040727161628.56a03aec.ak@suse.de>
In-Reply-To: <20040727161628.56a03aec.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407270815.39165.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 27, 2004 7:16 am, Andi Kleen wrote:
> On Mon, 26 Jul 2004 17:10:08 -0700
>
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> > So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
> > a more generally useful function than pcibus_to_cpumask().  If anyone
> > disagrees with that, now would be a good time to let us know.
>
> Not sure that is a good idea. Sometimes this information is not available.
> With pcibus_to_cpumask() the fallback is obvious, but it isn't with
> pcibus_to_node(). Returning a random node is wrong.

Hmm... so there's no way for you to get a node or nodemask at all?

> It's impossible currently - I need an ACPI 3.0 BIOS to get this
> information. Even then there will be machines who don't supply it.
>
> I tried some time ago to get it from the hardware, but the hardware
> registers were arcane enough that I didn't find it easy enough. Relying on
> firmware for this thing is probably a better idea anyways.

Yeah, it's easier that way, but for the first cut on ia64, I'm gonna have to 
do it by hand too.  It's not that bad on sn2 at least.

Jesse
