Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269150AbUINGSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269150AbUINGSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUINGSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:18:12 -0400
Received: from holomorphy.com ([207.189.100.168]:22929 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269150AbUINGSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:18:10 -0400
Date: Mon, 13 Sep 2004 23:18:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, raybry@sgi.com, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914061807.GE9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040913220507.1a269816.davem@davemloft.net> <20040914053218.GB9106@holomorphy.com> <20040913224943.04761a15.davem@davemloft.net> <20040914061023.GC9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914061023.GC9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 11:10:23PM -0700, William Lee Irwin III wrote:
> Well, that would speed it up, but the catastrophe was avoided in the
> older patches by just processing all the hits for one cpu at a time,
> and the buffering methods above for your suggested accounting
> structures likely work well enough the overhead of processing unused
> portions of the bitmap can be ignored. I don't really want to go about
> addressing performance issues besides effective or actual
> nontermination for this code, and would rather leave highly efficient
> methods to oprofile (in fact, some others believe that even bugfixes
> for such issues should be ignored for kernel/profile.c, contrary to my
> notion that it shouldn't crash systems regardless of their size).

s/portions of the bitmap/portions of the profile buffer/
