Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUFBOuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUFBOuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUFBOuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:50:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:26508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263093AbUFBOuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:50:22 -0400
Date: Wed, 2 Jun 2004 07:49:31 -0700
From: Greg KH <greg@kroah.com>
To: Manu Abraham <manu@kromtek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Minor numbers under 2.6
Message-ID: <20040602144931.GA25424@kroah.com>
References: <200406021519.32128.manu@kromtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406021519.32128.manu@kromtek.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 03:19:32PM +0400, Manu Abraham wrote:
> Hi,
> 	Can somebody clarify a question that i have ?
> 
> 	Say under 2.4 kernel, char device drivers had a minor number of int. In the 
> 2.6 kernels, this number was increased to 20 bits from 8 bits. Under 2.6 i 
> could use "mknod -c major, minor". 
> 
> 	How can i achieve something similar with 2.6 taking into consideration that i 
> have to create more than 255 minors ?

The same way:
	# mknod foo c 100 10000
	# ls -l foo 
	crw-r--r--  1 root root 100, 10000 Jun  2 07:48 foo

Just make sure you have a up to date glibc.

Hope this helps,

greg k-h
