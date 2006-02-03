Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWBCAAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWBCAAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWBCAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:00:23 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:10822 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932495AbWBCAAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:00:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NwzghKKUdF/DdDMtVFxEYfipARqQBtQUMsH3aLpWD3mFwBU2PBPlHAR46K0SjcHFdfVSZUuVZDQwNrPI8ua8LOoTMW/8K0U0fYinDn+/W2rfnZKRkVOYZN3b+SKNM79R5wo8eMjUk9zGp4s63BA6avyq4Krp1Ymg6QT52AwnTdQ=
Date: Fri, 3 Feb 2006 03:18:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extract-ikconfig: be sure binoffset exists before extracting
Message-ID: <20060203001838.GA18431@mipter.zuzino.mipt.ru>
References: <20060201125658.GB8943@mipter.zuzino.mipt.ru> <20060202153241.48b206fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202153241.48b206fb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 03:32:41PM -0800, Andrew Morton wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > --- a/scripts/extract-ikconfig
> > +++ b/scripts/extract-ikconfig
> > @@ -4,6 +4,7 @@
> >  # $arg1 is [b]zImage filename
> >  
> >  binoffset="./scripts/binoffset"
> > +test -e $binoffset || cc -o $binoffset ./scripts/binoffset.c || exit 1
> >  
> 
> OK, but it would be better if we could find a way of doing this within a
> Makefile.

AFAICS, it's a standalone script for CONFIG_IKCONFIG=y,
CONFIG_IKCONFIG_PROC=n users.

