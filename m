Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVB1TTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVB1TTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVB1TTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:19:05 -0500
Received: from sd291.sivit.org ([194.146.225.122]:19915 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261712AbVB1TS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:18:58 -0500
Date: Mon, 28 Feb 2005 20:18:56 +0100
From: Stelian Pop <stelian@popies.net>
To: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Message-ID: <20050228191855.GC17559@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>,
	linux-kernel@vger.kernel.org, arjan@infradead.org
References: <20050228164456.GB17559@sd291.sivit.org> <Pine.GSO.4.40.0502281817001.27182-100000@ensisun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.40.0502281817001.27182-100000@ensisun>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 06:29:39PM +0100, emmanuel.colbus@ensimag.imag.fr wrote:

> Well, without it, it gives :
> 
> 
> 
> --- old/drivers/char/vt.c 2004-12-24 22:35:25.000000000 +0100
> +++ new/drivers/char/vt.c 2005-02-28 18:19:11.782717810 +0100
> @@ -1655,8 +1655,8 @@
> vc_state = ESnormal;
> return;
> case ESsquare:
> - for(npar = 0 ; npar < NPAR ; npar++)
> - par[npar] = 0;
> + memset(par, 0, NPAR*sizeof(unsigned int));
> npar = 0;
> vc_state = ESgetpars;
> if (c == '[') { /* Function key */
> 
> 
> 
> 
> Any other comments/remarks, or is _this_ patch version acceptable?

A not whitespace-mangled version of it could be.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
