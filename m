Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUHRVg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUHRVg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUHRVfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:35:50 -0400
Received: from holomorphy.com ([207.189.100.168]:51897 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267758AbUHRVfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:35:42 -0400
Date: Wed, 18 Aug 2004 14:35:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040818213538.GK11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20040818133348.7e319e0e.pj@sgi.com> <20040818135401.670f11bd.davem@redhat.com> <20040818141541.467e1e2d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818141541.467e1e2d.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Miller wrote:
>> Each platform needs different args, unfortunately.

On Wed, Aug 18, 2004 at 02:15:41PM -0700, Paul Jackson wrote:
> Doesn't that make it kinda rough on the folks trying to write
> arch-independent code, such as sound/core/pcm_native.c that I am
> tripping over?
> I can imagine a possible 'solution' something like (1) always passing
> six args, and (2) providing arch-dependent macros to generate those last
> two args, from some arch-generic value.
> Just brainstorming ...

This would not be useful. The extra argument is so that 64-bit values
don't have to be passed. Keeping the minimal number of arguments and
changing its meaning to be a pfn will suffice for the purposes here.


-- wli
