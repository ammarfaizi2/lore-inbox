Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWFSWMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWFSWMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWFSWMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:12:16 -0400
Received: from iabervon.org ([66.92.72.58]:22537 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964931AbWFSWMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:12:15 -0400
Date: Mon, 19 Jun 2006 18:14:28 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: linux-kernel@vger.kernel.org, Joshua Hudson <joshudson@gmail.com>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
In-Reply-To: <44964EDC.3030104@ums.usu.ru>
Message-ID: <Pine.LNX.4.64.0606191801000.6713@iabervon.org>
References: <20060618221343.GA20277@kroah.com>  <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
  <4495F5C3.1030203@zytor.com>  <bda6d13a0606181817q2ab4e5cev670ef5c537b63e6c@mail.gmail.com>
  <4495FF59.2010100@zytor.com> <8e6f94720606182255u400964c2v1ea16221ffc5c94d@mail.gmail.com>
 <44964EDC.3030104@ums.usu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Alexander E. Patrakov wrote:

> Will Dyson wrote:
> > Providing the information about what devices a virtual driver will
> > register when loaded seems like a good idea.
> 
> Why? This information is currently useless. What you want is that something
> knows that you want this driver to be loaded.

The point is that you *don't* want those modules to be loaded. What you 
want is for the kernel to know that those modules are available, and 
therefore mention that drivers could be found for those devices, and 
therefore udev would create the device nodes for them, even though the 
kernel doesn't contain a module that drives them yet.

If something actually opens the device node, the module will be loaded, 
but until then it isn't using up resources.

	-Daniel
*This .sig left intentionally blank*
