Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVATWFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVATWFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVATWEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:04:21 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:17677 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262081AbVATWCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:02:23 -0500
Date: Thu, 20 Jan 2005 17:01:21 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [patch 2.4.29] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050120220120.GF7687@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
References: <20050120202258.GA7687@tuxdriver.com> <20050120210739.GC7687@tuxdriver.com> <20050120212346.GD7687@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120212346.GD7687@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 04:23:46PM -0500, John W. Linville wrote:

> +	/* if we are currently stopped, then our CIV is actually set to our
> +	 * *last* sg segment and we are ready to wrap to the next.  However,
> +	 * if we set our LVI to the last sg segment, then it won't wrap to
> +	 * the next sg segment, it won't even get a start.  So, instead, when
> +	 * we are stopped, we increment the CIV value to the next sg segment
> +	 * to be played so that when we call start, things will operate
> +	 * properly
> +	 */

Herbert,

Is this (slightly altered) comment more to your liking?  If so,
I'll post an additive patch for the 2.6 version...

John
-- 
John W. Linville
linville@tuxdriver.com
