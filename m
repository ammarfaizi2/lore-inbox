Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTKTTUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTKTTUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:20:43 -0500
Received: from jupiter.loonybin.net ([208.248.0.98]:52488 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S262991AbTKTTUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:20:41 -0500
Date: Thu, 20 Nov 2003 13:20:27 -0600
From: Zinx Verituse <zinx@epicsol.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] cuecat serio driver for linux 2.6.0-test9
Message-ID: <20031120192027.GA7520@bliss>
References: <20031120014514.GA4573@bliss> <20031120113249.A30030@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120113249.A30030@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 11:32:49AM +0000, Christoph Hellwig wrote:
> On Wed, Nov 19, 2003 at 07:45:14PM -0600, Zinx Verituse wrote:
[snip]
> > 
> > The major number is dynamicly allocated -- If you aren't using devfs,
> > check /proc/devices.
> > The minor number for reading all cuecats is 0, and the minor number
> > for individual cuecats is their [driver-assigned] index plus 1.
> > Recommended names are:
> > 	/dev/cuecat/cuecats
> > 	/dev/cuecat/0
> > 	/dev/cuecat/1
> > and so on.
> 
> Hmm?  A 2.6 input driver shouldn't create devices bz itself but rather use
> the input core to communicated with the upper drivers like evdev or moused..
> 

The input core really is designed for actual input devices, rather
than devices that send out arbitrary largish amounts of data.

The driver would probably be simplified a bit (superficially) by
sending barcodes as events (it would have to be multiple events
per barcode -- the input core has very small communications with
userland), but it would complicate userspace quite a bit, and it's
really just not the sort of thing I'd expect in the input core.

However, if you can think of a way to send the barcodes as a single
event, without changing the userland input core interface, I'm all
ears :)

-- 
Zinx Verituse
