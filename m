Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129419AbRCBSsk>; Fri, 2 Mar 2001 13:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbRCBSsa>; Fri, 2 Mar 2001 13:48:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:47049 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129428AbRCBSsV>;
	Fri, 2 Mar 2001 13:48:21 -0500
Date: Fri, 2 Mar 2001 18:46:27 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>, Robert Read <rread@datarithm.net>
Subject: Re: [patch] set kiobuf io_count once, instead of increment
Message-ID: <20010302184627.A28854@redhat.com>
In-Reply-To: <20010227162222.A6389@tenchi.datarithm.net> <Pine.LNX.4.21.0102272234380.7124-100000@freak.distro.conectiva> <20010228091859.A9540@tenchi.datarithm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010228091859.A9540@tenchi.datarithm.net>; from rread@datarithm.net on Wed, Feb 28, 2001 at 09:18:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 28, 2001 at 09:18:59AM -0800, Robert Read wrote:
> On Tue, Feb 27, 2001 at 10:50:54PM -0300, Marcelo Tosatti wrote:

> This is true, but it looks like the brw_kiovec allocation failure
> handling is broken already; it's calling __put_unused_buffer_head on
> bhs without waiting for them to complete first.  Also, the err won't
> be returned if the previous batch of bhs finished ok.  It looks like
> brw_kiovec needs some work, but I'm going to need some coffee first...

Right, looks like this happened when somebody was changing the bh
submission mechanism to use submit_bh().  I'll fix it.

--Stephen
