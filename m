Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWCAWeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWCAWeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCAWeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:34:31 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:62982 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751325AbWCAWea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:34:30 -0500
Date: Wed, 1 Mar 2006 23:34:30 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Ren? Rebe <rene@exactcode.de>, linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060301223430.GA9159@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>, Ren? Rebe <rene@exactcode.de>,
	linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <20060301213223.GA17270@kroah.com> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301215423.GA17825@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 01:54:23PM -0800, Greg KH wrote:
> On Wed, Mar 01, 2006 at 10:42:35PM +0100, Ren? Rebe wrote:
> > So, queing alot URBs is the recommended way to sustain the bus? Allowing
> > way bigger buffers will not be realistic?
> 
> 16Kb is "way big" in the USB scheme of things aready.  Look at the size
> of your endpoint.  It's probably _very_ small compared to that.  So no,
> larger buffer sizes is not realistic at all.

As a data point, I have traces of a scanner session including a
download of a 26Mb binary image using 524288 bytes logical blocks
physically transferred with 61440 bytes bulk_in frames.  Seems stable
enough.  IIRC the scanner-side controller chip has some advanced
buffering just to handle that kind of bandwidth.

ISTR a preliminary linux userland driver using libusb having problems
keeping up with the scanner too.  May very well have been an issue
with the driver itself though, so I wouldn't read too much into that.

  OG.

