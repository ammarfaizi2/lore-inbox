Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWIWUYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWIWUYD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWIWUYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:24:03 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:46540 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751541AbWIWUYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:24:01 -0400
Date: Sat, 23 Sep 2006 22:29:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060923202912.GA22293@uranus.ravnborg.org>
References: <20060923154416.GH29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923154416.GH29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 04:44:16PM +0100, Al Viro wrote:
> indirect chains of includes are arch-specific and can't
> be relied upon...  (hell, even attempt to build it for
> itanic would trigger vmalloc.h ones; err.h triggers
> on e.g. alpha).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/infiniband/core/mad_priv.h           |    1 +
>  drivers/infiniband/hw/amso1100/c2_provider.c |    1 +
>  drivers/infiniband/hw/amso1100/c2_rnic.c     |    1 +
>  drivers/infiniband/hw/ipath/ipath_diag.c     |    1 +
>  4 files changed, 4 insertions(+), 0 deletions(-)
A better fix would be to avoid the arch dependency in the non-arch .h
files so that in most cases it just works??

That will result in a few files being included twice or more but
does that matter with current gcc - I doubt.

	Sam
