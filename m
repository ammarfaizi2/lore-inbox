Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbTE1MXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTE1MXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:23:08 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:65242 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264705AbTE1MXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:23:07 -0400
Subject: Re: [Linux-fbdev-devel] [PATCH] fix controlfb and platinumfb
	drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <16083.61404.354044.232004@nanango.paulus.ozlabs.org>
References: <16079.23061.979768.135318@argo.ozlabs.ibm.com>
	 <Pine.LNX.4.44.0305272328300.26160-100000@phoenix.infradead.org>
	 <16083.61404.354044.232004@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054125376.538.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 May 2003 14:36:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-28 at 01:08, Paul Mackerras wrote:
> James Simmons writes:
> 
> > Applied. Tho it is strnage. You shouldn't need to call fb_set_var from the 
> > driver. 
> 
> It's just convenient to use fb_set_var to get the hardware set to the
> initial mode.  Would it be better to call controlfb_check_var,
> controlfb_set_par, etc., directly?

I think we are supposed to rely on the console subsytem opening us thus
doing a set_par() with the initial var rather than doing set_var ourselves,
but I'm not too sure, I added those set_var at a time where I had incorrect
results without, we may be able to remove them by now...

Ben.

