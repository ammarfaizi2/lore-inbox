Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUILE6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUILE6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 00:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268445AbUILE6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 00:58:41 -0400
Received: from holomorphy.com ([207.189.100.168]:7811 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268438AbUILE6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 00:58:22 -0400
Date: Sat, 11 Sep 2004 21:58:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Roger Luethi <rl@hellgate.ch>, Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040912045810.GB2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
	Andrew Morton OSDL <akpm@osdl.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch> <1094941556.1173.12.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094941556.1173.12.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 15:11, Roger Luethi wrote:
>> I have a few minor changes coming up as well.
>> One nitpick: As vmexe and vmlib are always 0 for !CONFIG_MMU, we should
>> ifdef them out of the list of offered fields for that configuration (and
>> maybe in nproc_ps_field as well).

On Sat, Sep 11, 2004 at 06:25:56PM -0400, Albert Cahalan wrote:
> No. First of all, I think they can be offered. Until proven
> otherwise, I'll assume that the !CONFIG_MMU case is buggy.
> Second of all, removal will make the !CONFIG_MMU systems
> less compatible with the rest of the world. This will
> mean that fewer apps can run on !CONFIG_MMU boxes. It's
> same problem as "All the world's a VAX". It's better that
> the apps work; an author working on a Pentium 4 Xeon is
> likely to write code that relies on the fields and might
> not really understand what "no MMU" is all about.

Would the nommu bits I wrote be satisfactory for you?


-- wli
