Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbTDDNcq (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTDDNZ5 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:25:57 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:53516 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263530AbTDDNVd (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:21:33 -0500
Date: Fri, 4 Apr 2003 14:33:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: i2c_probe() vs i2c_detect()
Message-ID: <20030404143301.B25147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <20030403012307.GA6037@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030403012307.GA6037@kroah.com>; from greg@kroah.com on Wed, Apr 02, 2003 at 05:23:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 05:23:07PM -0800, Greg KH wrote:
> Hi all,
> 
> Can anyone tell me why both i2c_probe() and i2c_detect() are in the
> kernel at the same time?  They both almost do the same thing, with the
> exception being i2c_detect() can handle i2c devices on the isa bus.
> 
> It kind of looks like the older i2c code and drivers used the
> i2c_probe() call, while the lm_sensors code used i2c_detect().
> 
> If there are no objections, I'll merge the two of them, cutting about 2k
> out of the kernel :)

Once ou're at it you could also try to get rid of the check_region abuse
in there :)

