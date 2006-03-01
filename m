Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWCAREe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWCAREe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWCAREe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:04:34 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:12462 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932191AbWCAREd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:04:33 -0500
X-IronPort-AV: i="4.02,157,1139212800"; 
   d="scan'208"; a="310800557:sNHT31884020"
To: Jes Sorensen <jes@sgi.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
X-Message-Flag: Warning: May contain useful information
References: <1140841250.2587.33.camel@localhost.localdomain>
	<yq08xrvhkee.fsf@jaguar.mkp.net>
	<1141149475.24103.18.camel@camp4.serpentine.com>
	<44057B46.1010403@sgi.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 01 Mar 2006 09:04:29 -0800
In-Reply-To: <44057B46.1010403@sgi.com> (Jes Sorensen's message of "Wed, 01 Mar 2006 11:45:26 +0100")
Message-ID: <adawtfeyu3m.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Mar 2006 17:04:30.0389 (UTC) FILETIME=[347D7E50:01C63D52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jes> Anyway, based on Jesse and Jeremy's comments, then maybe the
    Jes> semantics here are different. However I do think the name
    Jes> wc_wmb() isn't quite defining it. If it's only to be used on
    Jes> mmio space, something like mmio_wc_wmb() would probably be
    Jes> more descriptive.

I don't see any restriction to MMIO space -- it would be a strange
thing to do, but conceivable one might want to order writes that are
made to ordinary RAM via a write-combining mapping.

 - R.
