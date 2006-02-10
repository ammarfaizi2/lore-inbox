Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWBJOwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWBJOwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWBJOwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:52:45 -0500
Received: from thunk.org ([69.25.196.29]:13548 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751265AbWBJOwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:52:44 -0500
Date: Fri, 10 Feb 2006 09:52:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210145238.GC18707@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECA3FC.nailJGC110XNX@burner>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 03:32:28PM +0100, Joerg Schilling wrote:
> > Chapter and verse, please?  
> >
> > Can you please list the POSIX standard, section, and line number which
> > states that a particular device must always have the same st_rdev
> > across reboots, and hot plugs/unplugs?
> 
> A particular file on the system must not change st_dev while the system
> is running.
> 
> http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html

1)  File != device.

2)  st_dev != st_rdev

3) The reference you specified says nothing about st_dev (or st_rdev)
being invariant while the system is runnning.  Line number, please?

4) POSIX/SUS is very careful not to define what dev_t.  Use of mknod to
create block/chracter devices, and depending on any properties of
dev_t is likely to get you into trouble.

5) The st_rdev of a particular file, like /dev/hda *does* remain
invariant.  The device which it points to may change, but that's a
different matter --- and POSIX/SUS is very deliberately silent on your
subject.

THEREFORE, your claim that Linux's behaviour violates POSIX/SUS is
demonstrably false.  Quod erat demonstratum.

						- Ted
