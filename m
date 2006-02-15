Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946026AbWBORHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946026AbWBORHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946029AbWBORHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:07:50 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:58760
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1946026AbWBORHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:07:49 -0500
Date: Wed, 15 Feb 2006 09:07:40 -0800
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, davidsen@tmr.com,
       nix@esperi.org.uk, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060215170740.GE1546@kroah.com>
References: <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <20060213154921.GA22597@kroah.com> <Pine.LNX.4.61.0602151643470.25885@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602151643470.25885@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 04:44:38PM +0100, Jan Engelhardt wrote:
> >
> >Of course not.  Here's one line of bash that gets you the major:minor
> >file of every block device in the system:
> >	block_devices="$(echo /sys/block/*/dev /sys/block/*/*/dev)"
> >
> When was that added? /sys/block/hdc/device/ only has "power", "block", 
> "bus" and "driver" here on a 2.6.13-rc3.

True, that's why my above "echo" didn't point to "device" but "dev".
"device" is a symlink to the device that the block device is attached
to.  "dev" is the major:minor number of this specific block device.

Hope this helps,

greg k-h
