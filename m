Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755290AbWKMRyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbWKMRyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbWKMRyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:54:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:31367 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1755290AbWKMRyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:54:31 -0500
Date: Mon, 13 Nov 2006 09:07:50 -0800
From: Greg KH <greg@kroah.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Aubrey <aubreylee@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to add a device file to sysfs?
Message-ID: <20061113170750.GB14925@kroah.com>
References: <6d6a94c50610302130u55fc3f59n7be157a73c50805e@mail.gmail.com> <20061103045235.GA24467@kroah.com> <45584CE2.7090104@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45584CE2.7090104@ens-lyon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 11:45:54AM +0100, Brice Goglin wrote:
> Greg KH wrote:
> > On Tue, Oct 31, 2006 at 01:30:36PM +0800, Aubrey wrote:
> >   
> >> I've read the doc under linux-2.6.x/Documentation, I can add it to
> >> some other directory, but not found a way to add it to my own
> >> directory.
> >>     
> >
> > After misc_register() has been successfully called, the variable "class"
> > will be set in the miscdevice structure.  Use that pointer to call
> > class_device_create_file() to create your new file in this directory.
> >   
> 
> How does it work in -mm where miscdevice does not contain a "class"
> anymore, but only pointers to some "device"?

Then use device_create_file() instead :)

Good luck,

greg k-h
