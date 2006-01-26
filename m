Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWAZS2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWAZS2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWAZS2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:28:19 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:28177 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932397AbWAZS2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:28:19 -0500
Date: Thu, 26 Jan 2006 19:28:18 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126182818.GA44822@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <20060126175506.GA32972@dspnet.fr.eu.org> <20060126181034.GA9694@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126181034.GA9694@suse.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 07:10:34PM +0100, Vojtech Pavlik wrote:
> The kernel interface is sysfs and hotplug.

Hotplug, of course, can't be used from a program.  As for sysfs, as
said in the mail to Jens, I'm not sure how to:

- find the devices, what should I scan/filter on.  udev seems likes it
  needs to run a program (/sbin/cdrom_id) or scan
  /proc/sys/dev/cdrom/info just to know if a device is a cdrom...

- find the /dev name associated to a sysfs-found device.


> Udev interfaces that and can be set up so that it assigns
> /dev/cdrecorder0, 1, ... to evey recorder in the system, implementing
> the userspace interface.

Problem is, udev doesn't.  Or at least it varies from distribution to
distribution.  For instance recent gentoo creates /dev/cdrom*,
/dev/cdrw*, /dev/dvd*, /dev/dvdrw*.  Fedora core 3 creates
/dev/cdrom*, /dev/cdwriter*, /dev/dvd*, /dev/dvdwriter*.  I guess from
your email that SuSE does /dev/cdrecorder*.  And I'm not able to
guess what fedora core 5, mandrake, debian, slackware and infinite
number of derivatives do.


> HAL interfaces the above and implements the desktop interface.

I'm not sure how trustable HAL is at that point given what's going on
with udev and I'm not too happy to have to require to daemons (dbus
system and hald) to run to find the devices, but heh...

  OG.
