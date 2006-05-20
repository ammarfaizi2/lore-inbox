Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWETWAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWETWAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWETWAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 18:00:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:61752 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964775AbWETWAE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 18:00:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=flS89sQUlFhMfWHi2VUNAQ8LJZD3S4GM80fJA2eK7AiQ0pE8onsq5SsuoeFmnea6RrdRTwXql9ivn18HSE7MKS80PqPgl7ZyRAHWf2Z48yBQr/iP3PkmA7mX5S+oSllbECAEuXhdiVtD5sELzQ4BOeOdZvKG+H+iPLUsVEq4dbs=
Message-ID: <305c16960605201500s6153e1doad87e4b85f15b53f@mail.gmail.com>
Date: Sat, 20 May 2006 19:00:02 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Chris Wedgwood" <cw@f00f.org>
Subject: Re: [RFC PATCH (take #2)] i386: kill CONFIG_REGPARM completely
Cc: "Christoph Hellwig" <hch@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>
In-Reply-To: <20060520212049.GA11180@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060520025353.GE9486@taniwha.stupidest.org>
	 <20060520090614.GA9630@infradead.org>
	 <20060520201357.GA32010@taniwha.stupidest.org>
	 <20060520212049.GA11180@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/06, Chris Wedgwood <cw@f00f.org> wrote:
> Take #2.
>
> Kill of CONFIG_REGPARM completely.
>
>
> diff --git a/Documentation/stable_api_nonsense.txt b/Documentation/stable_api_nonsense.txt
> index f39c9d7..ac11b81 100644
> --- a/Documentation/stable_api_nonsense.txt
> +++ b/Documentation/stable_api_nonsense.txt
> @@ -62,9 +62,8 @@ consider the following facts about the L
>        - different structures can contain different fields
>        - Some functions may not be implemented at all, (i.e. some locks
>         compile away to nothing for non-SMP builds.)
> -      - Parameter passing of variables from function to function can be
> -       done in different ways (the CONFIG_REGPARM option controls
> -       this.)
> +      - Parameter passing of variables from function to function can
> +       be done in different ways.

Why not kill those 2 lines too? Now that non-regparm is gone, it
doesnt make sense to say there are different ways to pass parameters,
there is only regparm now, right?

>
