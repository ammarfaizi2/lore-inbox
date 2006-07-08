Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWGHAXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWGHAXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWGHAXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:23:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62917 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932441AbWGHAX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:23:28 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 8/8] Optimize mempolicies for a single zone
Date: Sat, 8 Jul 2006 02:17:45 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com> <20060708000543.3829.24370.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000543.3829.24370.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080217.46036.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#ifndef SINGLE_ZONE
> +#define policy_zone ZONE_NORMAL
> +#else
>  extern int policy_zone;
> +#endif
> 
>  static inline void check_highest_zone(int k)
>  {
> +#ifndef SINGLE_ZONE
>  	if (k > policy_zone)
>  		policy_zone = k;
> +#endif

This looks ugly. What's wrong the simple variable?

-Andi
