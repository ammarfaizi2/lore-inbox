Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUIOQSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUIOQSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUIOQSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:18:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:2212 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266768AbUIOQQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:16:50 -0400
Date: Wed, 15 Sep 2004 09:11:37 -0700
From: Greg KH <greg@kroah.com>
To: Ian Campbell <icampbell@arcom.com>
Cc: "Giacomo A. Catenazzi" <cate@debian.org>, "Marco d'Itri" <md@Linux.IT>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Message-ID: <20040915161137.GB21971@kroah.com>
References: <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org> <1095258966.18800.34.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095258966.18800.34.camel@icampbell-debian>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:36:06PM +0100, Ian Campbell wrote:
> On Wed, 2004-09-15 at 14:55, Giacomo A. Catenazzi wrote:
> > Old behaviour (modprobe "waits" for the creation of device):
> 
> I wonder if it would be feasible for modprobe (or some other utility) to
> have a new option: --wait-for=/dev/something which would wait for the
> device node to appear.

Why?  What's the point?  You are asking to paper over the way the kernel
works (remember storage devices are on lots of different kinds of busses
today...)

The fact that a static /dev keeps these race conditions from showing up
as often as they really are there is no reason to keep trying to rely on
old, undefined behaviour :)

thanks,

greg k-h
