Return-Path: <linux-kernel-owner+w=401wt.eu-S1161044AbXAEKdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbXAEKdE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbXAEKdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:33:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:34646 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161044AbXAEKdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:33:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=X15hrUNB3SinMdmWv0x4cctY6xfzOrTwoyhzePXGGs2+JLsUVtEd+WJqPkHqCk9/CyDK6NicQ7a3cgf/DvNXr6h1M8vUXUA+B4Q6hGYa0GHk8XK/vMHgg7u9zFVtWehiWcHU07bxqJ41p4UZg8oRs6m7eGEGpO+hxNYjfZvctHQ=
Date: Fri, 5 Jan 2007 12:32:47 +0200
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Message-ID: <20070105103247.GC382@Ahmed>
Mail-Followup-To: Rolf Eike Beer <eike-kernel@sf-tec.de>,
	linux-kernel@vger.kernel.org
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de> <20070105100610.GA382@Ahmed> <200701051126.13682.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701051126.13682.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 11:26:07AM +0100, Rolf Eike Beer wrote:

> One big patch for the whole kernel will not work anyway. You have to split it 
> up to allow subsystems to integrate them in their own trees. With one big 
> patch you would get collisions all over the tree causing the complete patch 
> to get dropped. Also CC subsystem maintainers on their parts. And please send 
> the patches as replies to the first one as it cleans up readability of lkml a 
> lot :)

Oops, Just read this warning after sending the (big) patch. Sorry It's my first
patch :). I'll split it and do as written. Thanks alot :).

> > I think this will be better done in another patch to let every patch do one
> > single thing. right ?
> 
> Yes. But I would suggest starting with the kmalloc()->kzalloc() things. When 
> you do this conversions just remove the casts of the lines you're touching. 
> This will reduce the size of the complete thing avoiding two rather trivial 
> patches touching the same line twice.
> 
> Eike

OK. In progress

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
