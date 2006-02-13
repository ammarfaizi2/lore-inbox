Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWBMWPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWBMWPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWBMWPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:15:30 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:35332 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030212AbWBMWPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:15:30 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: greg@kroah.com, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	<20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
	<20060125181847.b8ca4ceb.grundig@teleline.es>
	<20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
	<878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
	<20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner>
From: Nix <nix@esperi.org.uk>
X-Emacs: or perhaps you'd prefer Russian Roulette, after all?
Date: Mon, 13 Feb 2006 22:14:25 +0000
In-Reply-To: <43F0891E.nailKUSCGC52G@burner> (Joerg Schilling's message of
 "Mon, 13 Feb 2006 14:26:54 +0100")
Message-ID: <871wy6sy7y.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Joerg Schilling stated:
> Greg KH <greg@kroah.com> wrote:
> 
>> On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
>> > 
>> > The kernel could provide a list of devices by category. It doesn't have 
>> > to name them, run scripts, give descriptions, or paint them blue. Just a 
>> > list of all block devices, tapes, by major/minor and category (ie. 
>> > block, optical, floppy) would give the application layer a chance to do 
>> > it's own interpretation.
>>
>> It does so today in sysfs, that is what it is there for.
> 
> Do you really whant libscg to open _every_ non-directory file under /sys?

Well, that would be overkill, but iterating across, say,
/sys/class/scsi_device seems like it would be a good idea.

(I doubt libscg would ever be interested in the stuff in most of the
other directories: things like /dev/mem are not SCSI devices and never
will be, and /sys/class/scsi_device contains *everything* Linux
considers a SCSI device, no matter what transport it is on, SATA and
all. However, I don't know if it handles IDE devices that you can SG_IO
to because I don't have any such here. Anyone know?)

-- 
`... follow the bouncing internment camps.' --- Peter da Silva
