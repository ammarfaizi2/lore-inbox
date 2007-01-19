Return-Path: <linux-kernel-owner+w=401wt.eu-S965120AbXASNBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbXASNBq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 08:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbXASNBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 08:01:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:7179 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965120AbXASNBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 08:01:46 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OqSQlJAiDqPPk5x2VP8bgCEKw2x6HtzlLXjj09L/KxX2Lsxfy5arkmTbQIaQnF8aLLIsJp1AZpleUh02PSUM2COqevNzmF/OTGPqxD8UkS0chV5q6EKd6JbvbN5giAeBAKmZ8b1Ap6fEL5s+Ab44/d0GkQtE76bLvglVbl+xgSI=
Message-ID: <84144f020701190501x5d1efb49u87dc9537bfe1e791@mail.gmail.com>
Date: Fri, 19 Jan 2007 15:01:44 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: can someone explain "inline" once and for all?
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
X-Google-Sender-Auth: 88d1b9f57032ad2f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
> is there a simple explanation for how to *properly* define inline
> routines in the kernel?  and maybe this can be added to the
> CodingStyle guide (he mused, wistfully).

AFAIK __always_inline is the only reliable way to force inlining where
it matters for correctness (for example, when playing tricks with
__builtin_return_address like we do in the slab).

Anything else is just a hint to the compiler that might be ignored if
the optimizer thinks it knows better.
