Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWHIGGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWHIGGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWHIGGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:06:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:32487 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030503AbWHIGGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:06:22 -0400
From: Andi Kleen <ak@suse.de>
To: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller)
Date: Wed, 9 Aug 2006 08:06:04 +0200
User-Agent: KMail/1.9.3
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, rohitseth@google.com,
       "Dave Hansen" <haveblue@us.ibm.com>, "Kirill Korotaev" <dev@sw.ru>,
       vatsa@in.ibm.com, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>, mingo@elte.hu, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       pj@sgi.com, "Andrey Savochkin" <saw@sw.ru>
References: <20060804050753.GD27194@in.ibm.com> <p73d5bao7d9.fsf@verdi.suse.de> <aec7e5c30608082300t3b903e89rff302dc25339c720@mail.gmail.com>
In-Reply-To: <aec7e5c30608082300t3b903e89rff302dc25339c720@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090806.04615.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I've been thinking a bit about replacing the mapping and index members
> in struct page with a single pointer that point into a cluster data
> type. The cluster data type is aligned to a power of two and contains
> a header that is shared between all pages within the cluster. The
> header contains a base index and mapping. The rest of the cluster is
> an array of pfn:s that point back to the actual page.

Nice. While the code would probably do more references i bet
it would be faster overall because it would have less cache footprint.

But doing it would be a *lot* of editing work all over file systems/VM/etc.

-Andi
