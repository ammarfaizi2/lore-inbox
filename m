Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbUBXWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUBXWJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:09:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:36795 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262326AbUBXWJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:09:53 -0500
Date: Tue, 24 Feb 2004 14:09:46 -0800
From: Greg KH <greg@kroah.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <20040224220946.GA2389@kroah.com>
References: <Pine.LNX.4.58.0402240919490.1129@spektro.metla.fi> <20040224170412.GA31268@kroah.com> <1077642529.1804.170.camel@mulgrave> <20040224171629.GA31369@kroah.com> <20040224101512.A19617@beaverton.ibm.com> <Pine.LNX.4.58.0402242028370.3713@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402242028370.3713@kai.makisara.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 11:48:32PM +0200, Kai Makisara wrote:
> On Tue, 24 Feb 2004, Patrick Mansfield wrote:
> 
> ...
> > Current 2.6 kernel default names are of the form: st[0-9]m[0-3][n]
> > 
> Actually more like  st[0-9]*m[0-9]*[n]
> 
> > Current /dev naming is of the form: [n]st[0-9][alm]
> > 
> Depends on who's /dev you are looking at.

How about everyone look at devices.txt as that is the LSB standard.

> > Should the st kernel names be changed to map to current /dev names?
> > 
> I don't think we should go back to the old names. The intention with the 
> "new" names was to make them easier to parse and handle than the old ones. 
> The number of modes is not always four. Anyone can compile st with more or 
> less modes. Using a number for the mode is naturally extensible. The 
> characters at the end of the old names had interpretations that may not be 
> correct in all cases (a=alternate, l=low density, m=medium density).
> 
> n has been put at the end of the name because now the tape names are 
> grouped together in a listing. I know this is a weak justification ;-)
> 
> > For udev, even with that we need differing pre and postfix values wrapped
> > around a peristent name.
> > 
> If I read udev correctly, it can now parse one number at the end of the 
> name. Something like st%md%n and nst%md%n could be used with eight rules 
> (where %m is the mode number and %n is the device number). Not very 
> convenient. Parsing the st names should really be able to extract at 
> least two fields. With an external program, anything can be done. Maybe 
> udev can some day do this internally.

Well, udev didn't think that anyone would do such a looney thing in
nameing devices :)

But yes, I'll be glad to fix up udev if you all fix up the tape sysfs
names to match device.txt.

thanks,

greg k-h
