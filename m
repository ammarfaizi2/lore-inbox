Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSF0Azu>; Wed, 26 Jun 2002 20:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSF0Azt>; Wed, 26 Jun 2002 20:55:49 -0400
Received: from holomorphy.com ([66.224.33.161]:51668 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316712AbSF0Azt>;
	Wed, 26 Jun 2002 20:55:49 -0400
Date: Wed, 26 Jun 2002 17:54:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Bongani <bonganilinux@mweb.co.za>,
       Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
Message-ID: <20020627005431.GM22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Bongani <bonganilinux@mweb.co.za>,
	Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org> <20020626204721.GK22961@holomorphy.com> <1025125214.1911.40.camel@localhost.localdomain> <1025128477.1144.3.camel@icbm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025128477.1144.3.camel@icbm>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 17:00, Bongani wrote:
> The preemptive kernel is not part of 2.4-ac.

On Wed, Jun 26, 2002 at 05:54:13PM -0400, Robert Love wrote:
> Btw, fwiw, I do not think this problem has anything to do with
> preemption.  The "exited with preempt_count" message just means the task
> exited with preemption disabled.  It is not a problem if the task died
> abnormally.

Well, my concern here is for the pte_chain_lock() / pte_chain_unlock()
bits. Teaching them about preemption should be all that's needed there.


Cheers,
Bill
