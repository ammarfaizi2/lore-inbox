Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275616AbTHOAYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275619AbTHOAYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:24:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:33501 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275616AbTHOAWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:22:44 -0400
Date: Thu, 14 Aug 2003 17:22:20 -0700
From: Greg KH <greg@kroah.com>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "'Patrick Mochel'" <mochel@osdl.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shm to sysfs rebuild.
Message-ID: <20030815002220.GC4776@kroah.com>
References: <D9B4591FDBACD411B01E00508BB33C1B014053B7@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B014053B7@mesadm.epl.prov-liege.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 03:03:43PM +0200, Frederick, Fabian wrote:
> Patrick,
> 
> 	Here's the patch attached (patches are troublesome when inlined from
> here).
> btw all your advices were applied.

Don't you really want to clean up the shm information when the device is
closed (or however shm's are destroyed), and then later, when the
kobject is released, free up the memory assigned to it?

The patch really wasn't inlined, otherwise I would point this out in the
patch :)

thanks,

greg k-h
