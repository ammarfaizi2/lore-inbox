Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUIUImm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUIUImm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 04:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIUImm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 04:42:42 -0400
Received: from holomorphy.com ([207.189.100.168]:14533 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267518AbUIUImk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 04:42:40 -0400
Date: Tue, 21 Sep 2004 01:42:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hawkes@sgi.com, raybry@sgi.com, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] fix timer interrupt livelock on 512x Altix
Message-ID: <20040921084232.GE9106@holomorphy.com>
References: <20040920213020.GX9106@holomorphy.com> <20040920221554.7f72f0eb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920221554.7f72f0eb.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  What this patch does is to create a pair of per-cpu open-addressed
>>  hashtables indexed by profile buffer slot holding values representing
>>  the number of pending profile buffer hits for the profile buffer slot.

On Mon, Sep 20, 2004 at 10:15:54PM -0700, Andrew Morton wrote:
> Needs a compile fix (see below).
> Also, goes oops on x86:

Okay, I'll resend after dealing with that. It looks obvious, but just
to cut down on noise and/or false starts I'll get it through a clean
ia32 boot before following up. It was runtime tested on x86-64, sparc64,
ia64, alpha, and ppc64 prior to posting, so it boggles my mind that a
bogon this obvious could have run that gauntlet undetected...


-- wli
