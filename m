Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268389AbUH2X0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268389AbUH2X0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbUH2X0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:26:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11241 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S268389AbUH2XZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:25:49 -0400
Date: Mon, 30 Aug 2004 01:25:43 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040829232543.GC24937@apps.cwi.nl>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <20040829184114.GS5492@holomorphy.com> <20040829192617.GB24937@apps.cwi.nl> <20040829212350.GX5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829212350.GX5492@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 02:23:50PM -0700, William Lee Irwin III wrote:

> The difference I cared the most about was algorithmic. A giant memcpy()
> of the profile buffer and making multiple passes over it is ridiculous.
> This was recoded as maintaining a buffer large enough to hold the
> length of the profile buffer spanning symbol currently being examined.
> In this way the memory resources required for it to operate are
> drastically reduced from multiple megabytes to just a few pages.

That is good - although so far I have not heard complaints
about readprofile's memory use. Maybe multiple MB is not
so excessive these days.

But improvement is always good.

On the other hand, I like stability. Maybe readprofile is just some
kind of throwaway utility, not very important, but nevertheless,
some people use it, and they have habits and hate to relearn,
and they have scripts, and hate to adapt these scripts.

So, if the internal code is improved, excellent, but I am not so
happy if the invocation is changed without a very good reason.

Maybe you can make a cross: your improved algorithm inside the
old framework with options and locale?

> The removal of -V was intentional, as I consider it bloat.

Don't you know that whenever there are complaints about software
the very first question is "which version?"?

> I wasn't really expecting much to come of it besides prodding people
> to clean up bloat. The reduced functionality alone likely precludes it
> from consideration for inclusion. Supposing that there is greater
> interest, which I don't expect, I can fix these things up and so on.

Well, you sent me something. I have three choices: take it as
replacement for the current version, ignore it, work on it.
I have no time to work on it, so am only happy with what you send
if it can replace the current version.

Andries
