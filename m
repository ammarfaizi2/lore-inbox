Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUJLO0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUJLO0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUJLOZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:25:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23779 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264396AbUJLOYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:24:03 -0400
Date: Mon, 11 Oct 2004 14:21:47 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [HID] Fix hiddev devfs oops
Message-ID: <20041011172147.GA3066@logos.cnet>
References: <20041005124914.GA1009@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005124914.GA1009@gondor.apana.org.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 10:49:14PM +1000, Herbert Xu wrote:
> Hi:
> 
> There is a long-standing devfs_unregister oops in hid/hiddev.  It's
> caused by hid calling hiddev_exit before unregistering itself which
> in turn calls hiddev_disconnect.
> 
> hiddev_exit removes the directory which contains the hiddev devices.
> Therefore it needs to be called after the hiddev devices have been
> disconnected.
> 
> This patch fixes that.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Marcelo, the same fix is needed in 2.4 as well.

Herbert,

Would be nice to have a version which applies to 2.4 also.
