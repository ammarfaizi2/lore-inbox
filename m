Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVD0NtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVD0NtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVD0Npa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:45:30 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:7081 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261525AbVD0NmU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OXOzjjWocHW7npCFwaNydwu+/Grxgyn1gg/GH2imjk8ZxL1G7cqj6rHntmsXM7JCMPCUgC4UI7WVTYuHTqLpWJItUWACvyErU7CJVskLgs//XoDLxjh3t/HXmTZDX5JsyYPwotStCGxO5XXt4+id/sjLq/htTYX3e5OYN5HG4Og=
Message-ID: <d120d500050427064250a9450b@mail.gmail.com>
Date: Wed, 27 Apr 2005 08:42:19 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/6] Toshiba driver cleanup
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050427003329.02dab427.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504270149.13450.dtor_core@ameritech.net>
	 <200504270150.06196.dtor_core@ameritech.net>
	 <20050427003329.02dab427.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/05, Andrew Morton <akpm@osdl.org> wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > Toshiba legacy driver cleanup:
> 
> --- 25/drivers/char/toshiba.c~toshiba-driver-cleanup-fix        2005-04-27 00:32:47.306512192 -0700
> +++ 25-akpm/drivers/char/toshiba.c      2005-04-27 00:32:51.521871360 -0700
> @@ -79,7 +79,7 @@ MODULE_DESCRIPTION("Toshiba laptop SMM d
> MODULE_SUPPORTED_DEVICE("toshiba");
> 
> static int tosh_fn;
> -module_param(fn, int, 0);
> +module_param(tosh_fn, int, 0);
> MODULE_PARM_DESC(tosh_fn, "User specified Fn key detection port");
> 

Ahem, sorry, somehow picked up bad version... It was supposed to be
module_param_named(). I will send an updated patch tonight.

-- 
Dmitry
