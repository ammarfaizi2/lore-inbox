Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVKLR2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVKLR2T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVKLR2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:28:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:55017 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932424AbVKLR2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:28:19 -0500
From: Andi Kleen <ak@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Date: Sat, 12 Nov 2005 18:21:11 +0100
User-Agent: KMail/1.8.2
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <200511110312.15616.ak@suse.de> <20051112092200.GA7997@midnight.suse.cz>
In-Reply-To: <20051112092200.GA7997@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121821.11552.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 10:22, Vojtech Pavlik wrote:

> Is there any advantage to using 64-bit HPET? 

Yes - it can tolerate long delays between ticks, e.g. caused by noidletick / 
debuggers / target probes / smm etc. At least the first case will be fairly
important soon.

> It's read is even slower 

Why? The read should be on cache line granuality and there shouldn't
be any difference in theory.

-Andi
