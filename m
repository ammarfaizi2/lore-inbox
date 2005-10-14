Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVJNEVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVJNEVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVJNEVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:21:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:47530 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751168AbVJNEVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:21:40 -0400
Date: Thu, 13 Oct 2005 21:20:58 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Bastian Blank <bastian@waldi.eu.org>, schwidefsky@de.ibm.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc4-git] s390, ccw - export modalias
Message-ID: <20051014042058.GA8232@kroah.com>
References: <20051012192639.GA25481@wavehammer.waldi.eu.org> <20051012125939.6ee58910.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012125939.6ee58910.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 12:59:39PM -0700, Andrew Morton wrote:
> Bastian Blank <bastian@waldi.eu.org> wrote:
> >
> > This patch exports modalias for ccw devices.
> 
> And why do we want to do that?

So you can do:
	modprobe `echo /sys/device/path_to_device/modalias`
and the proper driver will automatically be loaded by userspace.

thanks,

greg k-h
