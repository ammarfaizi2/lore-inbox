Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWA3Dth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWA3Dth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 22:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWA3Dth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 22:49:37 -0500
Received: from hera.kernel.org ([140.211.167.34]:64724 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750713AbWA3Dtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 22:49:36 -0500
Date: Sun, 29 Jan 2006 17:47:26 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Calin A. Culianu" <calin@ajvar.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Watchdog: Winsystems EPX-C3 SBC
Message-ID: <20060129234726.GA20923@dmt.cnet>
References: <Pine.LNX.4.64.0601132149430.9231@rtlab.med.cornell.edu> <1137266649.23269.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137266649.23269.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 07:24:09PM +0000, Alan Cox wrote:
> Some quick comments:
> 
> +       if (len) {
> +               epx_c3_pet();
> +       }
> 
> Doesn't need brackets (minor style)
> 
> Otherwise it looks excellent but should use request_region and friends
> to claim the two ports it uses.

It misses locking to protect against two concurrent writers in case of  
a shared /dev/wdt file-descriptor? 

