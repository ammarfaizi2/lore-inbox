Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUCaP2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUCaP2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:28:34 -0500
Received: from ida.rowland.org ([192.131.102.52]:7172 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262005AbUCaP2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:28:31 -0500
Date: Wed, 31 Mar 2004 10:28:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Leopold Gouverneur <gvlp@pi.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] speedtouch and/or USB problem (2.6.4-WOLK2.3)
In-Reply-To: <20040331141115.GA9792@gouv>
Message-ID: <Pine.LNX.4.44L0.0403311024520.1752-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Leopold Gouverneur wrote:

> On Sat, Mar 27, 2004 at 06:51:36PM -0500, Alan Stern wrote:
> > 
> > Try applying this patch:
> > 
> > http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108016447231291&q=raw
> > 
> > Alan Stern
> > 
> This patch seems to be included in 2.6.5-rc2 bk-curent but it don't
> solve the same problem with xsane (or scanimage) which hangs in
> ioctl(n, USBDEVFS_SETCONFIGURATION) when accessing my Epson USB Sc
> anner.Not the first time I run it but each time after that.
> The process remains in D state for many hours before returning for no
> evident reason.Was working fine in 2.6.3.

The short answer is that programs (like xsane or scanimage) generally
shouldn't be using the SETCONFIGURATION call.  The program should be 
fixed.

The longer answer is that several patches have been submitted in the last 
week that touch on this and other related problems.  They may appear in 
2.6.5-rc4 or later.

Alan Stern

