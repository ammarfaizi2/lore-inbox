Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbUJZFiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUJZFiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUJZFfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:35:13 -0400
Received: from sd291.sivit.org ([194.146.225.122]:52198 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261841AbUJZF3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:29:52 -0400
Date: Tue, 26 Oct 2004 07:29:51 +0200
From: Luc Saillard <luc@saillard.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.6.9-ac3
Message-ID: <20041026052951.GA4993@sd291.sivit.org>
References: <20041023193651.1cbcb80d.luca.risolia@studio.unibo.it> <417D7C9D.8040409@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417D7C9D.8040409@tmr.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:22:21PM -0400, Bill Davidsen wrote:
> >Hmm..What about a common library finally?
> 
> That sounds like the eventual solution. A vendor to common format 
> conversion library, and with luck someone will be clever and let the 
> driver select it in a nice acceptable way. Thought: after open an ioctl 
> to tell you which conversion to use? The optimal mechanics are 
> inobvious, but I think the library is the right idea.

It's difficult to create a API that will be use for anyone. I try to be
application developper and want to grab an image from a device. I need to
know the list of webcams, the list of capture devices, ... and want to
display some sliders to control the camera like red,blue,gamma, ...
I want one format even if it's not supported by the driver.

What's the goal of our API ?
 - open,close, enumerate any device (usb,pci, firewire, ...) on the host.
 - convert any format (i'm YetAnotherCameraApp, want a RGB image, but the
   driver only support YUV)
 - can recognize special video source and activate some features.
 - can be use by any program or language ?
 - provide API to change red, blue, balance, gamma, ... without using ioctl.
   Perhaps like Alsa, provinding two levels: - a hardware interface, and a
   software interface.
 - provides some additionals features, like flipping image, change
   colorspace, use MMX ...
 - Please insert any features you want.

The ffmpeg project have already some source code to convert data between
various format without loosing to much information. (Think YUV to RGB, and
RGB to YUV410P).

When i'll finished to support v4l2 for the PWC driver, i'll try to begin a
little library to be use and a sample application. But this takes times ...

Luc
