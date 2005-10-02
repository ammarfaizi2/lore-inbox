Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVJBHU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVJBHU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 03:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVJBHU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 03:20:26 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:54956 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751003AbVJBHUZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 03:20:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tz+DaDGuqUTNIDOK4Gt1r7gx2NlIDMq9eZUOGVscUlpspU1jAOX3X/sM2mohGW6UZC5ssTCt//kZuCckxhiShtfIJR9pPo+Hb5uldAzVhlKyLkv44Ps8CV853gKSoPtkVHLJJzYxGL3XkotEjHYFimb31lZGsK2VyB+oFtTSm3c=
Message-ID: <2cd57c900510020020i564d473fx95c608bcac93bea@mail.gmail.com>
Date: Sun, 2 Oct 2005 15:20:23 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Document from line in patch format
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20051002062135.32334.32895.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002062135.32334.32895.sendpatchset@jackhammer.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/05, Paul Jackson <pj@sgi.com> wrote:
> Document more details of patch format such as the "from" line
> used to specify the patch author, and provide more references
> for patch guidelines.
>
> Signed-off-by: Paul Jackson <pj@sgi.com>
>
> Index: 2.6.14-rc2-mm2/Documentation/SubmittingPatches
> ===================================================================
> --- 2.6.14-rc2-mm2.orig/Documentation/SubmittingPatches
> +++ 2.6.14-rc2-mm2/Documentation/SubmittingPatches
> @@ -301,8 +301,47 @@ now, but you can do this to mark interna
>  point out some special detail about the sign-off.
>
>
> +12) The canonical patch format
>
> -12) More references for submitting patches
> +The canonical patch subject line is:
> +
> +    Subject: [PATCH 001/123] [<area>:] <explanation>
> +
> +The canonical patch message body contains the following:
> +
> +    The first line of the body contains a "from" line specifying
> +    the author of the patch:
> +
> +        From: Original Author <author@email.com>
> +
> +    If the "from" line is missing, then the author of the patch will
> +    be recorded in the source code revision history as whomever is
> +    listed in the last "Signed-off-by:" line in the message when Linus
> +    receives it.
> +
> +    The "from" line is followed by an empty line and then the body
> +    of the explanation.
> +
> +    After the body of the explanation comes the "Signed-off-by:"
> +    lines, and then a simple "---" line, and below that comes the
> +    diffstat of the patch and then the patch itself.  The "---" line
> +    and diffstat are optional, but helpful to readers of non-trivial
> +    patches.
> +
> +The Subject line format makes it very easy to sort the emails
> +alphabetically by subject line - pretty much any email reader will
> +support that - since because the sequence number is zero-padded,
> +the numerical and alphabetic sort is the same.
> +
> +See further details on how to phrase the "<explanation>" in
> +the "Subject:" line in Andrew Morton's "The perfect patch",
> +referenced below.
> +
> +See more details on the proper patch format in the following
> +references.
> +
> +
> +13) More references for submitting patches
>
>  Andrew Morton, "The perfect patch" (tpp).
>    <http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>
> @@ -310,6 +349,14 @@ Andrew Morton, "The perfect patch" (tpp)
>  Jeff Garzik, "Linux kernel patch submission format."
>    <http://linux.yyz.us/patch-format.html>
>
> +Jeff Garzik, "How to piss off a kernel subsystem maintainer"
> +  <http://www.kroah.com/log/2005/03/31/>
> +
> +Kernel Documentation/CodingStyle
> +  <http://lxr.linux.no/source/Documentation/CodingStyle>

There's another one more updated at http://sosdg.org/~coywolf/lxr/source/

> +
> +Linus Torvald's mail on the canonical patch format:
> +  <http://lkml.org/lkml/2005/4/7/183>
>

--
Coywolf Qi Hunt
