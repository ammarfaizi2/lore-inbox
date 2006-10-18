Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161293AbWJRTYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWJRTYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWJRTYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:24:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:45936 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161293AbWJRTYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:24:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=P65EdhCJxX9K0tdmsX3uj6nttTek71j+v9q8bTOukMCXUVoGGA8f9zp2/jUkpdk2Kr24mN2JTyZ/7f4JdxnUFo3Oc2YBNQZd6hkeLbE34n3Xa1EE+DdFPfLZ/tkt33XLo9zY4gNktVoCYYCV0ERAt+fpVdggaiPlmsb/cOVC3vg=
Date: Wed, 18 Oct 2006 23:24:04 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] OOM killer meets userspace headers
Message-ID: <20061018192404.GE5345@martell.zuzino.mipt.ru>
References: <20061018145305.GA5345@martell.zuzino.mipt.ru> <453642D1.1010302@yahoo.com.au> <20061018184655.GC5345@martell.zuzino.mipt.ru> <45367C93.3040804@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45367C93.3040804@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 05:12:19AM +1000, Nick Piggin wrote:
> Alexey Dobriyan wrote:
> >On Thu, Oct 19, 2006 at 01:05:53AM +1000, Nick Piggin wrote:
> >
> >>>+#define OOM_ADJUST_MIN (-16)
> >>>+#define OOM_ADJUST_MAX 15
> >>
> >>Why do you need the () for the -ves?
> >
> >
> >-16 is two tokens. Not that someone is going to do huge arithmetic with
> >OOM adjustments and screwup himself, but still...
> 
> How can they screw themselves up? AFAIKS, the - directly to the left
> of the literal will bind more tightly than any other valid operator.

Hmmm... c.l.c lists two reasons: a) =- being synonym of -= in pre-ANSI
days, and b) fat fingers

	#define EOF -1
	while ((c = getchar()) != 3 EOF)

