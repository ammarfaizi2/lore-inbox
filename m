Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269706AbUINUT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269706AbUINUT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269734AbUINUSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:18:50 -0400
Received: from holomorphy.com ([207.189.100.168]:60053 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269699AbUINTXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:23:12 -0400
Date: Tue, 14 Sep 2004 12:23:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914192303.GD9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914155103.GR9106@holomorphy.com> <20040914160531.GP4180@dualathlon.random> <200409140916.48786.jbarnes@engr.sgi.com> <20040914190030.GZ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914190030.GZ9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 14, 2004 9:05 am, Andrea Arcangeli wrote:
>>> Before dedicidng I'd suggest to have a look and see how the below patch
>>> compares to your approch in performance terms.

On Tue, Sep 14, 2004 at 09:16:48AM -0700, Jesse Barnes wrote:
>> It looks like the 512p we have here is pretty heavily reserved this
>> week, so I'm not sure if I'll be able to test this (someone else
>> might, John?). I think the balance we're looking for is between
>> simplicity and non-brokenness. Builtin profiling is *supposed* to be
>> simple and dumb, and were it not for the readprofile times, I'd say
>> per-cpu would be the way to go just because it retains the
>> simplicity of the current approach while allowing it to work on
>> large machines (as well as limiting the performance impact of
>> builtin profiling in general). wli's approach seems like a
>> reasonable tradeoff though, assuming what you suggest doesn't work.

On Tue, Sep 14, 2004 at 12:00:30PM -0700, William Lee Irwin III wrote:
> Goddamn fscking short-format VHPT crap. Rusty, how the hell do I
> hotplug-ize this?

Successfully tested on x86-64.

-- wli
