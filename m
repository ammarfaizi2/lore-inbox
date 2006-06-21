Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWFUWW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWFUWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFUWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:22:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751478AbWFUWW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:22:27 -0400
Date: Wed, 21 Jun 2006 15:22:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
In-Reply-To: <20060621220656.GA10652@kroah.com>
Message-ID: <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jun 2006, Greg KH wrote:
>
>  123 files changed, 4169 insertions(+), 2440 deletions(-)

Btw, I get

  119 files changed, 3888 insertions(+), 2159 deletions(-)

Why? Becuause my default pull script has rename detection enabled, and I 
get:

 rename include/linux/{usb_cdc.h => usb/cdc.h} (100%)
 rename include/linux/{usb_input.h => usb/input.h} (100%)
 rename include/linux/{usb_isp116x.h => usb/isp116x.h} (100%)
 rename include/linux/{usb_sl811.h => usb/sl811.h} (71%)

which explains the off-by-four number (and the smaller number of 
lines changed).

Just out of interest, could you enable that in your scripts too, so that 
renames don't show up as huge deletes/creates (well, in this case, thet 
were pretty small files, but you get the idea)?

		Linus
