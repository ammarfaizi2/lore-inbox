Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUBSTrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUBSTr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:47:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:9631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267514AbUBSTrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:47:02 -0500
Date: Thu, 19 Feb 2004 11:46:10 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040219194610.GB13934@kroah.com>
References: <20040219191636.GC10527@kroah.com> <Pine.LNX.4.44.0402191933350.26894-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402191933350.26894-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 07:36:07PM +0000, James Simmons wrote:
> 
> Here is a question for you. Presently both the serial ttys and VT ttys 
> share the same major number. Minor number 1 to 63 is allocated to the VTs 
> and 64 and above to serial ttys. One of the great limitations for my home 
> system is that I can have only 63 VTs. Can udev work around this 
> limitation?

udev can create different /dev nodes for these devices.  But as udev
does not modify the kernel code at all, it can not "solve" the
duplication of numbers in the kernel at all.  Nor is it meant to.

Hope this helps,

greg k-h
