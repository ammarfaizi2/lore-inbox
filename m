Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWARCaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWARCaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWARCaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:30:55 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:18056 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S932526AbWARCay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:30:54 -0500
Date: Wed, 18 Jan 2006 03:30:49 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Michael Loftis <mloftis@wgops.com>
cc: Benjamin LaHaise <bcrl@kvack.org>, Cynbe ru Taren <cynbe@muq.org>,
       linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <A1F2470FFF6F1B84CEF78FC4@d216-220-25-20.dynip.modwest.com>
Message-ID: <Pine.LNX.4.60.0601180326250.30177@kepler.fjfi.cvut.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <20060117193913.GD3714@kvack.org>
 <Pine.LNX.4.60.0601172047560.25680@kepler.fjfi.cvut.cz>
 <A1F2470FFF6F1B84CEF78FC4@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Michael Loftis wrote:
> --On January 17, 2006 9:13:49 PM +0100 Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
> 
> > I've consulted this with Mark Salyzyn, because I thought it was a problem
> > of the AACRAID driver. But I was told, that there is nothing that AACRAID
> > can possibly do about it, and that it is a problem of the upper Linux
> > layers (block device layer?) that are strictly fault intollerant, and
> > thouth the problem was just an inconsistency of one particular localized
> > region inside /dev/sda2, Linux was COMPLETELY UNABLE (!!!!!) to read a
> > single byte from the ENTIRE VOLUME (/dev/sda)!
> 
> Actually...this is also related to how the controller reports the error. If it
> reports a device level death/failure rather than a read error, Linux is just

Yes, but that wasn't the case here. I've witnessed that a while ago, but 
this time, no. Just a read error, no device death nor going off-line. 
Otherwise I wouldn't be that much surprised that Linux didn't even try. 
The controller didn't do anything that would prevent system from reading. 
Windows used that and worked, Linux unfortunatelly didn't even try. That's 
why I'm talking about it here.

> taking that on face value.  Yup, it should retry though.  Other possibilities
> exist including the volume going offline at the controller level, having
> nothing to do with Linux, this is most often the problem I see with RAIDs.

Martin
