Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbUA0VNT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUA0VNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:13:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:51844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265664AbUA0VND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:13:03 -0500
Date: Tue, 27 Jan 2004 13:12:53 -0800
From: Greg KH <greg@kroah.com>
To: Jake Moilanen <moilanen@austin.ibm.com>, johnrose@austin.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH][2.6] PCI Scan all functions
Message-ID: <20040127211253.GA27583@kroah.com>
References: <1075222501.1030.45.camel@magik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075222501.1030.45.camel@magik>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 10:55:01AM -0600, Jake Moilanen wrote:
> There are some arch, like PPC64, that need to be able to scan all the
> PCI functions.  The problem comes in on a logically partitioned system
> where function 0 on a PCI-PCI bridge is assigned to one partition and
> say function 2 is assiged to another partition.  On the second
> partition, it would appear that function 0 does not exist, but function
> 2 does.  If all the functions are not scanned, everything under function
> 2 would not be detected.

Heh, I think the PPC64 people need to get together and all talk about
this, as I just got a different patch, that solves much the same problem
from John Rose (it's on the linuxppc64 mailing list.)

Can you two get together and not patch the same section of code to do
the same thing in different ways?

thanks,

greg k-h
