Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWCAWpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWCAWpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWCAWpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:45:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:59852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751101AbWCAWpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:45:06 -0500
Date: Wed, 1 Mar 2006 14:41:23 -0800
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>, Ren? Rebe <rene@exactcode.de>,
       linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060301224123.GA10422@kroah.com>
References: <200603012116.25869.rene@exactcode.de> <20060301213223.GA17270@kroah.com> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com> <20060301223430.GA9159@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301223430.GA9159@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 11:34:30PM +0100, Olivier Galibert wrote:
> On Wed, Mar 01, 2006 at 01:54:23PM -0800, Greg KH wrote:
> > On Wed, Mar 01, 2006 at 10:42:35PM +0100, Ren? Rebe wrote:
> > > So, queing alot URBs is the recommended way to sustain the bus? Allowing
> > > way bigger buffers will not be realistic?
> > 
> > 16Kb is "way big" in the USB scheme of things aready.  Look at the size
> > of your endpoint.  It's probably _very_ small compared to that.  So no,
> > larger buffer sizes is not realistic at all.
> 
> As a data point, I have traces of a scanner session including a
> download of a 26Mb binary image using 524288 bytes logical blocks
> physically transferred with 61440 bytes bulk_in frames.  Seems stable
> enough.  IIRC the scanner-side controller chip has some advanced
> buffering just to handle that kind of bandwidth.

That's impressive.  What are the endpoint sizes on the device that did
this?

thanks,

greg k-h
