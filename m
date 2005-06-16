Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVFPSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVFPSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVFPSnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:43:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:13538 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261685AbVFPSnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:43:21 -0400
Date: Thu, 16 Jun 2005 11:43:12 -0700
From: Greg KH <greg@kroah.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com
Subject: Re: [patch 2.6.12-rc3] Adds persistent entryies using request_firmware_nowaitManuel Estrada Sainz <ranty@debian.org>,
Message-ID: <20050616184312.GA11542@kroah.com>
References: <20050616003414.GA1814@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616003414.GA1814@littleblue.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 07:34:14PM -0500, Abhay Salunke wrote:
> This is a patch to make the /sys/class/firmware entries persistent. 
> This has been tested with dell_rbu; dell_rbu was modified to not call
> request_firmware_nowait again form the callback function. 
> 
> The new mechanism to make the entries persistent is as follows
> 1> echo 0 > /sys/class/firmware/timeout
> 2> echo 2 > /sys/class/firmware/xxx/loading
> 
> step 1 prevents timeout to occur , step 2 makes the entry xxx persistent
> 
> if we want to remove persistence then do this
> ech0 -2 > /sys/class/firmware/xxx/loading

Hm, those are some mighty "magic" numbers that will be tough for people
to realize exactly what they mean.  Try adding a "persistant" file
instead.

> + /*
> + * 2005-06-15: 	Abhay Salunke <abhay_salunke@dell.com>
> + *		Added firmware persistent when request_firmware_nowait.
> + *		is called. 
> + */

Don't add changelog comments to .c files.  That belongs in the git tree,
not in the code itself.

Also, your use of tabs and spaces are wrong in a lot of places...

thanks,

greg k-h
