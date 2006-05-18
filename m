Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWERQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWERQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWERQA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:00:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:46289 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751359AbWERQA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:00:26 -0400
From: Andi Kleen <ak@suse.de>
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
Date: Thu, 18 May 2006 18:00:21 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20060518091410.CC527679F4@ozlabs.org> <p73y7wz30a1.fsf@bragg.suse.de> <1147966886.8469.4.camel@localhost.localdomain>
In-Reply-To: <1147966886.8469.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181800.21829.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 17:41, Michael Ellerman wrote:
> On Thu, 2006-05-18 at 15:55 +0200, Andi Kleen wrote:
> > Michael Ellerman <michael@ellerman.id.au> writes:
> > 
> > > Currently printk is no use for early debugging because it refuses to actually
> > > print anything to the console unless cpu_online(smp_processor_id()) is true.
> > 
> > On x86-64 this is simply solved by setting the boot processor online very early.
> 
> Yeah, someone suggested that. Unfortunately it doesn't work, we actually
> want to call printk before we even know which cpu we're on :D

You mean smp_processor_id() returns a random value?

Then your patch is broken too because iirc it tested smp_processor_id()
before that other flag

-Andi
