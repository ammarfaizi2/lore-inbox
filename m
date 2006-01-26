Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWAZSKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWAZSKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWAZSKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:10:19 -0500
Received: from styx.suse.cz ([82.119.242.94]:56713 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932381AbWAZSKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:10:18 -0500
Date: Thu, 26 Jan 2006 19:10:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126181034.GA9694@suse.cz>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <20060126175506.GA32972@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126175506.GA32972@dspnet.fr.eu.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 06:55:07PM +0100, Olivier Galibert wrote:

> > I believe that if you added Linux 2.6 support code in libscg/cdrecord,
> > that'd simply accept the device name as an argument and didn't use *any*
> > scanning code at all, you'd make a lot of people happy (*). Quite possibly
> > everyone minus one man. Which would be a great achievement.
> 
> Since Jens does not seem available anymore do you know how one is
> supposed to do the cdrom-ish device enumeration at that point?  Is HAL
> the official kernel interface to that now?
 
The kernel interface is sysfs and hotplug.

Udev interfaces that and can be set up so that it assigns
/dev/cdrecorder0, 1, ... to evey recorder in the system, implementing
the userspace interface.

HAL interfaces the above and implements the desktop interface.

So for a GUI application it's appropriate to use HAL, while a command
line program doesn't need any enumeration, as 'ls /dev/cdrecorder*'
should be enough for an experienced user.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
