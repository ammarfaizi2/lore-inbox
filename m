Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUINGXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUINGXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUINGXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:23:48 -0400
Received: from holomorphy.com ([207.189.100.168]:25489 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269065AbUINGXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:23:20 -0400
Date: Mon, 13 Sep 2004 23:23:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Albert Cahalan <albert@users.sf.net>, Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, Roger Luethi <rl@hellgate.ch>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914062307.GF9106@holomorphy.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch> <1094941556.1173.12.camel@cube> <20040914055946.GA20929@k3.hellgate.ch> <20040914061800.GD9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914061800.GD9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, could you comment on this since there are some people having
trouble figuring out what's going on with VM-related /proc/ fields for
!CONFIG_MMU. Please forgive the top-posting, it made more sense to
quote the text below in this instance.

On Tue, Sep 14, 2004 at 07:59:46AM +0200, Roger Luethi wrote:
>> I agree with you that those specific fields should be offered for
>> !CONFIG_MMU. However, if for some reason they cannot carry a value
>> that fits the field description, they should not be offered at all. The
>> ambiguity of having 0 mean either "0" or "this field is not available"
>> is bad. Trying to read a specific field _can_ fail, and applications
>> had better handle that case (it's still trivial compared to having to
>> parse different /proc file layouts depending on the configuration).

On Mon, Sep 13, 2004 at 11:18:00PM -0700, William Lee Irwin III wrote:
> Apart from doing something it's supposed to for !CONFIG_MMU and using
> the internal kernel accounting I set up for the CONFIG_MMU=y case I'm
> not very concerned about this. I have a vague notion there should
> probably be some consistency with the /proc/ precedent but am not
> particularly tied to it. We should probably ask Greg Ungerer (the
> maintainer of the external MMU-less patches) about what he prefers
> since it's likely we can't anticipate all of the !CONFIG_MMU concerns.

On Tue, Sep 14, 2004 at 07:59:46AM +0200, Roger Luethi wrote:
>> The presumed wrong assumptions underlying broken tools of the future
>> are not a good base for designing a new interface. My interest is in
>> making it easy to write correct applications (or in fixing broken apps
>> that won't work, say, on !CONFIG_MMU systems).

On Mon, Sep 13, 2004 at 11:18:00PM -0700, William Lee Irwin III wrote:
> I don't really know what the approach to app compatibility used by
> userspace for !CONFIG_MMU is; I'll refer you to Greg Ungerer as my
> knowledge of the CONFIG_MMU usage models and/or whatever userspace
> is used in tandem with it outside the VM's internals is rather scant.
