Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVCGNMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVCGNMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVCGNMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:12:41 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:37062 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261156AbVCGNMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:12:30 -0500
Date: Mon, 7 Mar 2005 14:12:04 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix NULL pointer deference in ALPS
Message-ID: <20050307131203.GH8138@ens-lyon.fr>
References: <20050307122432.GG8138@ens-lyon.fr> <200503071606.33984.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503071606.33984.adobriyan@mail.ru>
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 04:06:33PM +0200, Alexey Dobriyan wrote:
> On Monday 07 March 2005 14:24, Benoit Boissinot wrote:
> 
> > alps_get_model returns a pointer or NULL in case of errors, so we need to
> > check for the results being NULL, not negative.
> 
> 2.6.11-bk2:	int alps_get_model(struct psmouse *psmouse)
> 	takes 1 argument, returns -1 on error
> 
> 2.6.11-mm1:	static struct alps_model_info *alps_get_model(struct psmouse *psmouse, int *version)
> 	takes 2 arguments, returns NULL on error
>

Sorry, i misreaded the vanilla code, it only applies to -mm.

Since it seems to be fixed in bk-input, please forget the patch.

Sorry.

Benoit
-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
