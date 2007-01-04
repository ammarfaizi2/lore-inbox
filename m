Return-Path: <linux-kernel-owner+w=401wt.eu-S965096AbXADWdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbXADWdL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbXADWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:33:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:55531 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965099AbXADWdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:33:10 -0500
X-Greylist: delayed 744 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 17:33:09 EST
Date: Thu, 4 Jan 2007 14:32:47 -0800
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [RFC,PATCHSET] Managed device resources
Message-ID: <20070104223247.GA29274@suse.de>
References: <1167146313307-git-send-email-htejun@gmail.com> <20070104221916.GI28445@suse.de> <459D7F23.7010807@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459D7F23.7010807@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 05:26:43PM -0500, Jeff Garzik wrote:
> Greg KH wrote:
> >Hm, but I guess without the follow-up patches for libata, it will not
> >really get tested much.  Jeff, if I accept this, what's your feelings of
> >letting libata be the "test bed" for it?
> 
> 
> It would be easiest for me to merge this through my 
> libata-dev.git#upstream tree.  That will auto-propagate it to -mm, and 
> ensure that both base and libata bits are sent in one batch.
> 
> Just shout if you see NAK-able bits...
> 
> Work for you?

That works for me.

The only question I have is on the EXPORT_SYMBOL() stuff for the new
driver/base/ functions.  Tejun, traditionally the driver core has all
exported symbols marked with EXPORT_SYMBOL_GPL().  So, any objection to
marking the new ones (becides the "mirror" functions) in this manner?

thanks,

greg k-h
