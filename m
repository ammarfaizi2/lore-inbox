Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTLXLcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 06:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTLXLcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 06:32:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:53409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263592AbTLXLcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 06:32:07 -0500
Date: Wed, 24 Dec 2003 03:32:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: GCS <gcs@lsc.hu>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.0-mm1
Message-Id: <20031224033200.0763f2a2.akpm@osdl.org>
In-Reply-To: <20031224095921.GA8147@lsc.hu>
References: <20031224095921.GA8147@lsc.hu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCS <gcs@lsc.hu> wrote:
>
> Hi,
> 
> On Tue, Dec 23, 2003 at 05:11:31AM +0200, Andrew Morton <akpm@osdl.org> wrote:
> 
> > It would be appreciated if people who have
> > significant patches in -mm could retest please.
>  It seems I can write CDs on my laptop now. AFAICR I was last trying it on
> test8, but it was the same: if the image is over ~400Mb, the machine
> freezes hard. If it's shorter, then it's ok, but still some lock or sth
> is not unlocked, as the CPU is used more and more about five secs by one
> or two percent. Sooner or later it's crashed as well, but I could
> restart the machine before that happened. Rebooting to 2.4.2x and
> writing CDs there was working all the time.
>  So I do not know if it's fixed since test8, or in 2.6.0-mm1, but I am
> happy with it. Also, I have two problems with 2.6.0-mm1:

> - I can not deselect CONFIG_SCSI, only module or built-in available.
>   Maybe something is depend on it, but could not figure out what (no
>   CONFIG_BLK_DEV_IDESCSI, nothing is selected under CONFIG_SCSI).

Yes, this part of the config system is hard.  It always has been.  It's
similar to "wtf do I have to enable to make the <foo> menu appear.

I bit of grepping tells us that CONFIG_USB_STORAGE turns on CONFIG_SCSI.

> - I have a synaptics touchpad, which is detected correctly, but only
>   works if I set psmouse_noext=1. Under vanilla 2.6.0 it still works this
>   way, but with 2.6.0-mm1 it works only on the console, but not under
>   XFree86. Strange, as gpm interprets the input and pipes thru gpmdata
>   to XFree86 4.3.0. Any idea what broke this configuration?

Peter or Dmitry may be able to tell us.
