Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWBYMGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWBYMGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBYMGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:06:50 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:48078 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932279AbWBYMGt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:06:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4rDvUSQTCjZhvWn2cNz/3AmD4cR2hLxXlYjMkOCGwi4ibzeiawCjkwn5yFod/0v+EjJGzkwWEa+4Xdc2pVXic84CXBwWKsdhmDsgvt9wXKriG+BhTibdhX/8GQtt8BuVjn44s4wtuJ1NDy7wkwE2O9IgsMsYev0+2O2Vgw1+ho=
Message-ID: <84144f020602250406v7295b185i5035baf217faec58@mail.gmail.com>
Date: Sat, 25 Feb 2006 14:06:48 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Steven Whitehouse" <swhiteho@redhat.com>
Subject: Re: GFS2 Filesystem [15/16]
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1140793662.6400.738.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140793662.6400.738.camel@quoit.chygwyn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Steven Whitehouse <swhiteho@redhat.com> wrote:
> +       nl = kmalloc(sizeof(struct nolock_lockspace), GFP_KERNEL);
> +       if (!nl)
> +               return -ENOMEM;
> +
> +       memset(nl, 0, sizeof(struct nolock_lockspace));

kzalloc, please.

> +       *lvbp = kmalloc(nl->nl_lvb_size, GFP_KERNEL);
> +       if (*lvbp)
> +               memset(*lvbp, 0, nl->nl_lvb_size);
> +       else
> +               error = -ENOMEM;

Likewise.

                                   Pekka
