Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751947AbWFUDUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbWFUDUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWFUDUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:20:53 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:29573 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1751947AbWFUDUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:20:52 -0400
Date: Tue, 20 Jun 2006 23:04:44 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] Implement kasprintf
Message-ID: <20060621030444.GG20625@skunkworks.cabal.ca>
References: <44988B5C.9080400@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44988B5C.9080400@goop.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 04:57:16PM -0700, Jeremy Fitzhardinge wrote:
> +char *kasprintf(gfp_t gfp, const char *fmt, ...)
> +{

Why not just asprintf? We don't have ksprintf... 

% grep EXPORT_SYMBOL lib/vsprintf.c
EXPORT_SYMBOL(simple_strtoul);
EXPORT_SYMBOL(simple_strtol);
EXPORT_SYMBOL(simple_strtoull);
EXPORT_SYMBOL(vsnprintf);
EXPORT_SYMBOL(vscnprintf);
EXPORT_SYMBOL(snprintf);
EXPORT_SYMBOL(scnprintf);
EXPORT_SYMBOL(vsprintf);
EXPORT_SYMBOL(sprintf);
EXPORT_SYMBOL(vsscanf);
EXPORT_SYMBOL(sscanf);

?

Cheers,
	Kyle M.
