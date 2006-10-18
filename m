Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWJRSrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWJRSrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbWJRSrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:47:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:40389 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422771AbWJRSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:47:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=tzP1wPRZLg5lrlAGlTfd2+Eyh3h+IL9Tiw+hUX6r37h7NW/mkiuzgJbI5rVTc+OqdDES+mohnCGWaa5z0HkFCkAypjORTN5QbFkwF/JusODZkk/GdJqN8XnXy9HIi0udy1c+8bCIGuOuJESC5+9iCyVTYigsrxl17nv7V0qkM5U=
Date: Wed, 18 Oct 2006 22:46:55 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] OOM killer meets userspace headers
Message-ID: <20061018184655.GC5345@martell.zuzino.mipt.ru>
References: <20061018145305.GA5345@martell.zuzino.mipt.ru> <453642D1.1010302@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453642D1.1010302@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:05:53AM +1000, Nick Piggin wrote:
> >+#define OOM_ADJUST_MIN (-16)
> >+#define OOM_ADJUST_MAX 15
>
> Why do you need the () for the -ves?

-16 is two tokens. Not that someone is going to do huge arithmetic with
OOM adjustments and screwup himself, but still...
15 is one token, so it's safe.

And if someone from kernel-janitors would go through tree and (without
fanatism) add additional parenthesis to where they belong, it would be
nice.

