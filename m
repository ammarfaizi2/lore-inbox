Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265339AbUGGTbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUGGTbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUGGTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:31:42 -0400
Received: from mail.shareable.org ([81.29.64.88]:52912 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265339AbUGGTbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:31:39 -0400
Date: Wed, 7 Jul 2004 20:31:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, bert hubert <ahu@ds9a.nl>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040707193125.GA17266@mail.shareable.org>
References: <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net> <20040706194034.GA11021@mail.shareable.org> <20040706131235.10b5afa8.davem@redhat.com> <20040706224453.GA6694@outpost.ds9a.nl> <20040706154907.422a6b73.davem@redhat.com> <20040707110653.7c49bef1@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707110653.7c49bef1@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> But: isn't it better to have just one sysctl parameter set
> (tcp_rmem) and set the window scale as needed rather than increasing
> the already bewildering array of dials and knobs?  I can't see why
> it would be advantageous to set a window scale of 7 if the largest
> possible window ever offered is limited to a smaller value?

That's a fair question.

It seems to me the only effects of a larger scale than necessary
are (a) the buffer size can be increased after the connection is
established, and (b) coarser granularity which can only degrade
performance over low mss links.

So why do we set a larger window scale than necessary?
Is it to support (a)?

-- Jamie

