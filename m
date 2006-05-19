Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWESVff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWESVff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWESVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 17:35:34 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24338 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964852AbWESVfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 17:35:34 -0400
Date: Fri, 19 May 2006 23:35:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format?
Message-ID: <20060519213509.GA362@mars.ravnborg.org>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3262@chicken.machinevisionproducts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3262@chicken.machinevisionproducts.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
> 
> #ifndef MODULE
> #define MODULE
> #endif
Kill these.
> 
> #ifndef CONFIG_PCI
> #error "This driver REQUIRES PCI support"
> #endif
> 
> #if defined(CONFIG_MODVERSIONS) && !defined(MODVERSIONS)
> #define MODVERSIONS /* force it on */ 
> #endif
Looks bogus. Either it is enabled or not.
You cannot change it like this.

	Sam
