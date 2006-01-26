Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWAZIXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWAZIXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 03:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWAZIXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 03:23:35 -0500
Received: from mail.gmx.de ([213.165.64.21]:7365 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932123AbWAZIXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 03:23:34 -0500
X-Authenticated: #428038
Date: Thu, 26 Jan 2006 09:23:24 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: grundig@teleline.es
Cc: axboe@suse.de, schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126082324.GB13125@merlin.emma.line.org>
Mail-Followup-To: grundig@teleline.es, axboe@suse.de,
	schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de,
	linux-kernel@vger.kernel.org, acahalan@gmail.com
References: <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <20060125182552.GB4212@suse.de> <20060125231422.GB2137@merlin.emma.line.org> <20060126020951.14ebc188.grundig@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060126020951.14ebc188.grundig@teleline.es>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, grundig@teleline.es wrote:

> It's too "much effort"? Basically, what linux is asking is that cdrecord
> stop wasting efforts trying to implement its own solution. Linux is 
> asking cdrecord to use SG_IO and leave device discovery and data transport
> issues to the platform.
> 
> Linux doesn't even need -scanbus for example. You could compile out that
> code. Device discovery is done by the platform - I find _scary_ that other
> "modern" operative systems don't have a way of providing device discovery
> services in 2006 and that a external app is needed but hey, people is free
> to design their operative system as they like. Linux provides it and leaves
> Schilling time to focus in other things. In my book, that's not "too much
> effort", is "less effort". If someone bugs you because SG_IO doesn't work
> just tell him to report the problem here - in fact cdrecord already has a
> "friendly" warning about "linux-2.5 and newer". The cdrecord low level
> scsi driver for SG_IO should be much simpler than all the others...

Well, you need to implement 30 (or so) platform-specific ways to get a
list of devices, and portable applications aren't going to do that. To
make it explicit: no way. It is a maintenance nightmare, 30 lowly-tested
pieces of code, too.

This sounds like a huge difference, but I don't believe it actually is.
Jörg is trying to fight the system rather than stop complaining to users
about their using /dev/hd*. The scanning code is there and can be made
working with little effort probably.

-- 
Matthias Andree
