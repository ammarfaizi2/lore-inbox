Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbTLRRA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 12:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265240AbTLRRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 12:00:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:1755 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265232AbTLRRAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 12:00:22 -0500
Date: Thu, 18 Dec 2003 08:37:56 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module use count & unloading
Message-ID: <20031218163756.GA20882@kroah.com>
References: <20031218150525.5504D12001E@sarkovy.koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218150525.5504D12001E@sarkovy.koeller.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 04:03:11PM +0100, Thomas Koeller wrote:
> Hi,
> 
> I just learned that it is expected behavior for a module
> to be in use while having an in-use count of zero, see
> http://bugme.osdl.org/show_bug.cgi?id=1693. If this is
> so, how am I supposed to know whether a module can safely
> be unloaded? It also seems the old 'autoclean / modprobe -k'
> functionality from 2.4 is no longer available in 2.6.

It wasn't safe to do that in 2.4 either.  That would easily unload your
USB controller drivers, USB keyboard and USB mouse drivers, as they all
do not increment their in-use count.

thanks,

greg k-h
