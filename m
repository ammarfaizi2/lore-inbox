Return-Path: <linux-kernel-owner+w=401wt.eu-S1752008AbXAQEQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbXAQEQ0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXAQEQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:16:26 -0500
Received: from mx1.suse.de ([195.135.220.2]:54772 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbXAQEQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:16:25 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 5/8] Make writeout during reclaim cpuset aware
Date: Wed, 17 Jan 2007 09:07:14 +1100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com> <20070116054809.15358.22246.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054809.15358.22246.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170907.14670.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 16:48, Christoph Lameter wrote:
> Direct reclaim: cpuset aware writeout
>
> During direct reclaim we traverse down a zonelist and are carefully
> checking each zone if its a member of the active cpuset. But then we call
> pdflush without enforcing the same restrictions. In a larger system this
> may have the effect of a massive amount of pages being dirtied and then
> either

Is there a reason this can't be just done by node, ignoring the cpusets? 

-Andi

