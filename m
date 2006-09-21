Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWIUAiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWIUAiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWIUAiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:38:13 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21559 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750849AbWIUAiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:38:11 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=vYCQ1EB0YcvKn9S9d4l/wdILRII8EUhdw3cu624uCKFGVxfbS53hKg4ufuJlqUn4r
	cgb4j8HRKntIX0Mr4tiHg==
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609201721360.2336@schroedinger.engr.sgi.com>
References: <1158718722.29000.50.camel@galaxy.corp.google.com>
	 <p7364fikcbe.fsf@verdi.suse.de>
	 <1158770670.8574.26.camel@galaxy.corp.google.com>
	 <200609202014.48815.ak@suse.de>
	 <Pine.LNX.4.64.0609201721360.2336@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 17:37:53 -0700
Message-Id: <1158799073.7207.35.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 17:23 -0700, Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Andi Kleen wrote:
> 
> > There are lots of different cases. At least for anonymous memory 
> > ->mapping should be free. Perhaps that could be used for anonymous
> > memory and a separate data structure for the important others.
> 
> mapping is used for swap and to point to the anon vma.
> 
> > slab should have at least one field free too, although it might be a different
> > one (iirc Christoph's rewrite uses more than the current slab, but it would
> > surprise me if he needed all) 
> 
> slab currently has lots of fields free but my rewrite uses all of them.
> And AFAICT this patchset does not track slab pages.
> 

Currently it doesn't track kernel memory.  That is why I don't want to
over load any of the existing fields.

> Hmm.... Build a radix tree with pointers to the pages?
> 

...my preference is to leave it in page struct...that has non-zero cost.

-rohit 

