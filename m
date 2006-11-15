Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932843AbWKOLcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbWKOLcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbWKOLcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:32:43 -0500
Received: from ns.suse.de ([195.135.220.2]:52658 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932843AbWKOLcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:32:42 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Wed, 15 Nov 2006 12:32:31 +0100
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com>
In-Reply-To: <200611151227.04777.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151232.31937.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 12:27, Eric Dumazet wrote:
> Seeing %gs prefixes used now by i386 port, I recalled seeing strange oprofile 
> results on Opteron machines.
> 
> I really think %gs prefixes can be expensive in some (most ?) cases, even if 
> the Intel/AMD docs say they are free.

They aren't free, just very cheap.

> 
> With the attached patch, I got 12.212 s, and a kernel text size reduction of 
> 3400 bytes.

Are the benchmark numbers stable? i.e. if you repeat them multiple times
with reboots do you still get the same difference?

-Andi
