Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUEMUGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUEMUGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUEMTwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:52:40 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:17897 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264894AbUEMTuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:50:23 -0400
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>
Subject: Re: PATCH: (as279) Don't delete interfaces until all are unbound
Date: Thu, 13 May 2004 21:50:21 +0200
User-Agent: KMail/1.5.4
Cc: Nuno Ferreira <nuno.ferreira@graycell.biz>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sf.net>
References: <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405132150.21710.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> +		/* Now that the interfaces are unbound, nobody should
> +		 * try to access them.
> +		 */

how is usbfs going to claim interfaces after this?

> + * Don't call this function unless you are bound to one of the interfaces
> + * on this device or you own the dev->serialize semaphore!

Owning dev->serialize won't stop an Oops if the interfaces are all NULL...

All the best,

Duncan.
