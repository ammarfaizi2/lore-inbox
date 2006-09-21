Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWIUAyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWIUAyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWIUAyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:54:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:51258 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWIUAyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:54:08 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=It95Q9w4NX0+oEFzF8ngFrLzsljj77jLEch54nlMWmnKLn0vVteUarOB78StniOX2
	oa3hdc70nQTvvzxa9tSpw==
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609201740530.2581@schroedinger.engr.sgi.com>
References: <1158718722.29000.50.camel@galaxy.corp.google.com>
	 <p7364fikcbe.fsf@verdi.suse.de>
	 <1158770670.8574.26.camel@galaxy.corp.google.com>
	 <200609202014.48815.ak@suse.de>
	 <Pine.LNX.4.64.0609201721360.2336@schroedinger.engr.sgi.com>
	 <1158799073.7207.35.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201740530.2581@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 17:53:40 -0700
Message-Id: <1158800020.7207.45.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 17:41 -0700, Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Rohit Seth wrote:
> 
> > ...my preference is to leave it in page struct...that has non-zero cost.
> 
> Oh. Making struct page bigger than a cacheline or not fitting exactly in a 
> cacheline has some costs.
> 

Isn't most of the architectures not defining WANT_PAGE_VIRTUAL and thus
the page structure on these is not fitting cache line well. In most of
these cases the additional pointer will actually make the structure 64
bytes on 64-bit machines.

-rohit

