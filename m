Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUIIVag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUIIVag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUIIVag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:30:36 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:10161 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S266169AbUIIVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:22:28 -0400
Date: Thu, 9 Sep 2004 23:19:57 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909211957.GA31413@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040908184028.GA10840@k3.hellgate.ch> <20040908184130.GA12691@k3.hellgate.ch> <20040909003529.GI3106@holomorphy.com> <20040909184300.GA28278@k3.hellgate.ch> <20040909184933.GG3106@holomorphy.com> <20040909191142.GA30151@k3.hellgate.ch> <20040909192313.GK3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909192313.GK3106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 12:23:13 -0700, William Lee Irwin III wrote:
> I took the structure fields to be just an argument passing convention
> giving the nommu case an identical prototype much like the helpers in

That seems rather confusing. We must special-case for !CONFIG_MMU
anyway because field IDs are tied to meaning, i.e. systems export
different sets of fields depending on this configuration setting. The
proc filesystem does the same, the difference is that a changing set
is easier to handle with nproc.

Roger
