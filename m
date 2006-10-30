Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161261AbWJ3T3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbWJ3T3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWJ3T3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:29:10 -0500
Received: from [198.99.130.12] ([198.99.130.12]:31629 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030405AbWJ3T3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:29:06 -0500
Date: Mon, 30 Oct 2006 15:26:57 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] uml ubd driver: reformat ubd_config
Message-ID: <20061030202657.GB6079@ccure.user-mode-linux.org>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan> <20061029192041.12292.95078.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029192041.12292.95078.stgit@americanbeauty.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 08:20:41PM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> -		return(1);
> +		ret = 1;
> +		goto out;

> +out:
> + 	return ret;

I think the original form should stay, except for the CodingStyle fix.
As Al once pointed out, 'goto out; ... out: return' is spelled
'return'.  If you have no cleanup to do before returning, you might as
well just return.

> +	if (n == -1) {
> +		ret = 0;
> +		goto out;
>  	}
> -	if(n == -1) return(0);

The comment should have noted the bug fix present here.

				Jeff
