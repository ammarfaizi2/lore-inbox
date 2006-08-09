Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWHIBeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWHIBeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWHIBeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:34:16 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60649 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030400AbWHIBeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:34:15 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=Zlg7J07furT9J8cUAFX0tklTP/m89aVltaOMnp1nXxyVTaSrpddmIE799BzdI55tV
	HeX1zvC1JRjrEmb1iReKQ==
Message-ID: <44D93B60.7030507@google.com>
Date: Tue, 08 Aug 2006 18:33:20 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808193325.1396.58813.sendpatchset@lappy>	<20060808193345.1396.16773.sendpatchset@lappy> <20060808135721.5af713fb@localhost.localdomain>
In-Reply-To: <20060808135721.5af713fb@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> How much of this is just building special case support for large allocations
> for jumbo frames? Wouldn't it make more sense to just fix those drivers to
> do scatter and add the support hooks for that?

Short answer: none of it is.  If it happens to handle jumbo frames nicely
that is mainly a lucky accident, and we do need to check that they actually
works.

Minor rant: the whole skb_alloc familly has degenerated into an unholy
mess and could use some rethinking.  I believe the current patch gets as
far as three _'s at the beginning of a function, this shows it is high
time to reroll the api.

Regards,

Daniel
