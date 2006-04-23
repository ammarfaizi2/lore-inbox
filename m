Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWDWMjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWDWMjH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWDWMjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:39:07 -0400
Received: from host-84-9-203-1.bulldogdsl.com ([84.9.203.1]:28170 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751397AbWDWMjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:39:07 -0400
Date: Sun, 23 Apr 2006 13:38:50 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>,
       e3-hacking@earth.li
Subject: Re: [PATCH] [LEDS] Amstrad Delta LED support
Message-ID: <20060423123850.GA18923@home.fluff.org>
References: <20060422130823.GP7570@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422130823.GP7570@earth.li>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 02:08:23PM +0100, Jonathan McDowell wrote:
> [Which tree should I be trying to submit this to? The patch is against
> and works fine with 2.6.17-rc2]

I prefer the following PM defines, so there is only
one block of CONFIG_PM

#ifdef CONFIG_PM
int foo_suspend(...)
{
}

int foo_resume(...)
{
}

#else
#define foo_suspend NULL
#define foo_resume NULL
#endif 

 
> +static struct platform_driver foo_driver = {
> +	.probe		= foo_probe,
> +	.remove		= foo_remove,
> +	.suspend	= foo_suspend,
> +	.resume		= foo_resume,
> +};

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
