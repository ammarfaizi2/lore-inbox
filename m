Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTLSHSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 02:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTLSHSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 02:18:05 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:39631 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261522AbTLSHSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 02:18:02 -0500
Date: Fri, 19 Dec 2003 08:18:00 +0100
From: bert hubert <ahu@ds9a.nl>
To: Yun Zhou <sraphim@mofd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HD access sluggish in 2.6.0
Message-ID: <20031219071800.GA8087@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Yun Zhou <sraphim@mofd.net>, linux-kernel@vger.kernel.org
References: <200312181957.05917.sraphim@mofd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312181957.05917.sraphim@mofd.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 07:57:05PM -0600, Yun Zhou wrote:
> I'm using a system with 1HD (DC WD600BB-00CAA1 60 GB) using kernel 2.6.0. 
> Whenever the system uses the disk extensively (copying a file, untarring, 
> etc.), it grinds to a near halt, with the CPU usage at about 100%, even for a 
> simple copying operation.

Please show the output of hdparm /dev/hda:
/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 117210240, start = 0

You will probably see using_dma = 0 there. This in turn probably means you
did not compile in the right IDE driver. Try hdparm -d1 /dev/hda, and/or
recompile your kernel.

> This problem is not present when using 2.4.22, nor any of the 2.4 series 
> kernels that I've tried. Does anyone know what is causing this?

You did not specify any details of your kernel compile so it is hard to
tell.


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
