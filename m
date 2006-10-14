Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWJNQK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWJNQK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 12:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWJNQK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 12:10:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:25793 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422703AbWJNQK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 12:10:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ku7gJTGFkJfV+t4Tz1whSCHitU5nEGaC5q8BYKCrNK01EToPDlA5RUjW6Qzj/d7vB2ZyhiFovHrZ9H30Sf7mTvald557YhuCPsj5TQwN+YkT/W0JLf2u5P2+JcdZWWTDKQur3q09TNnSjvr/usxGs3D+v2UtBuXsYfLPUUY0sEQ=
Message-ID: <45310C41.2030404@gmail.com>
Date: Sat, 14 Oct 2006 12:11:45 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Dittmer <jdi@l4x.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, trivial@rustcorp.com.au
Subject: Re: Add missing space in module.c for taintskernel
References: <20061013181049.GB17614@ppp0.net>
In-Reply-To: <20061013181049.GB17614@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> Obvious fix, against rc1-git10
>
> Signed-off-by: Jan Dittmer <jdi@l4x.org>
>   

My patch killed that space, thanks for catching it.

Acked-by: Florin Malita <fmalita@gmail.com>


> --- linux-2.6-amd64/kernel/module.c~	2006-10-13 17:41:32.000000000 +0200
> +++ linux-2.6-amd64/kernel/module.c	2006-10-13 17:41:40.000000000 +0200
> @@ -1342,7 +1342,7 @@ static void set_license(struct module *m
>  
>  	if (!license_is_gpl_compatible(license)) {
>  		if (!(tainted & TAINT_PROPRIETARY_MODULE))
> -			printk(KERN_WARNING "%s: module license '%s' taints"
> +			printk(KERN_WARNING "%s: module license '%s' taints "
>  				"kernel.\n", mod->name, license);
>  		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>  	}
>   

