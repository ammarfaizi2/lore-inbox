Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbTH0IJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 04:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTH0IJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 04:09:54 -0400
Received: from holomorphy.com ([66.224.33.161]:46261 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263223AbTH0IJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 04:09:53 -0400
Date: Wed, 27 Aug 2003 01:10:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: mfedyk@matchmail.com, Andrew Morton <akpm@osdl.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827081052.GY4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peter@chubb.wattle.id.au>, mfedyk@matchmail.com,
	Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030826181807.1edb8c48.akpm@osdl.org> <20030827012914.GB5280@matchmail.com> <20030827071648.GY1715@holomorphy.com> <16204.24623.273818.861350@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16204.24623.273818.861350@wombat.chubb.wattle.id.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 05:39:27PM +1000, Peter Chubb wrote:
> To calculate these you need a timestamp for last change, and a set of
> counters.
> Then code to update all the counters every time one of the sizes
> change (otherwise you need a timestamp for each counter) by adding
> current_size*(current_time - last_change_time) to each counter.

Hmm. Building a tiny integrated counter ADT sounds useful; I can just
park it on something easy like RSS and we can use it to crush the rest
when there's enough machinery to keep the non-integrated counters.


-- wli
