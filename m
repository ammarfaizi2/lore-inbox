Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWCTPi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWCTPi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWCTPiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:38:20 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:37682 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964904AbWCTPhs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:37:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JKw2uXMtflZVJ5TX4YwXntxshI94LITFUrBr8O3lT4v+iHdoFhJg3Y1nnyHDD1uhCl+6KPelx9NVrHXYvC08+3PANniZahqYPq+lqmddoqLWIyW2r945hEqCXpI1wuJCa53UBOeu7xIqn7fFNjfcu7dAHm0L5bnnJntCEc8gsns=
Message-ID: <84144f020603200737ra799407o29f902907e00cc2d@mail.gmail.com>
Date: Mon, 20 Mar 2006 17:37:46 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Oliver Neukum" <neukum@fachschaft.cup.uni-muenchen.de>
Subject: Re: [PATCH]micro optimization of kcalloc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de> wrote:
> --- linux-2.6.16-rc6-vanilla/include/linux/slab.h       2006-03-11 23:12:55.000000000 +0100
> +++ linux-2.6.16-rc6/include/linux/slab.h       2006-03-20 14:39:36.000000000 +0100
> @@ -118,7 +118,7 @@
>   */
>  static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
>  {
> -       if (n != 0 && size > INT_MAX / n)
> +       if (unlikely(size != 0 && n > INT_MAX / size ))

Please fix whitespace damage at the end.

                                     Pekka
