Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVGHEj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVGHEj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 00:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVGHEj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 00:39:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:14265 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262599AbVGHEjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 00:39:24 -0400
Date: Thu, 7 Jul 2005 21:29:22 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: device_find broken in 2.6.11?
Message-ID: <20050708042922.GA4603@kroah.com>
References: <1120796213.12218.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120796213.12218.55.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:16:53PM +1000, Rusty Russell wrote:
> Hi Greg,
> 
> 	I was getting oopses in kset_find_obj when calling device_find in
> 2.6.11.12.  Noone else in the kernel uses device_find, but I couldnt'
> see anything wrong with it (mind you, I can't understand the
> kset_find_obj code to judge it).
> 
> 	Iterating manually using bus_for_each_dev works though.
> 
> Known problem?

Yup, there's a reason no one uses it.  Use the version in 2.6.13-rc2, it
actually works.

What are you wanting to use it for?

thanks,

greg k-h
