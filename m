Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWCHVsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWCHVsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCHVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:48:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:63670 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932240AbWCHVsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:48:35 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store buffers
Date: Wed, 8 Mar 2006 15:21:18 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@osdl.org,
       paulus@samba.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain> <1141853919.11221.183.camel@localhost.localdomain> <1141854208.27555.1.camel@localhost.localdomain>
In-Reply-To: <1141854208.27555.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081521.19693.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 22:43, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 08:38 +1100, Benjamin Herrenschmidt wrote:
> 
> > I think people already don't undersatnd the existing gazillion of
> > barriers we have with quite unclear semantics in some cases, it's not
> > time to add a new one ...
> 
> What do you suggest I do, then?  This makes a substantial difference to
> performance for us.  Should I confine this somehow to the ipath driver
> directory and have a nest of ifdefs in an include file there?

I think doing it privately is the better solution because I don't think you 
have established it has an universal semantic that works
on all X86-64 systems.

And we don't have a portable way to do WC anyways, so there is 
no portable way to use it.

So just put an ifdef in.

-Andi
