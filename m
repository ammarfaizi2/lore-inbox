Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUJ1RnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUJ1RnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbUJ1RnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:43:23 -0400
Received: from fms.tor.istop.com ([66.11.182.43]:6533 "EHLO
	maximus.fullmotions.com") by vger.kernel.org with ESMTP
	id S261728AbUJ1RnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:43:14 -0400
Subject: Re: SSH and 2.6.9
From: Danny Brow <dan@fullmotions.com>
To: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>,
       Kernel-List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3u0sfs0fm.fsf@rajsekar.pc>
References: <1098906712.2972.7.camel@hanzo.fullmotions.com>
	 <Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost>
	 <1098912301.4535.1.camel@hanzo.fullmotions.com>
	 <1098913797.3495.0.camel@hanzo.fullmotions.com>
	 <m3u0sfs0fm.fsf@rajsekar.pc>
Content-Type: text/plain
Date: Thu, 28 Oct 2004 13:44:14 -0400
Message-Id: <1098985454.9722.9.camel@hanzo.fullmotions.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 14:07 +0530, Rajsekar wrote:
>  No, that is not the actual problem (even though it seems to solve it).
> The thing is, /dev/tty should be rw for everyone.
> What happens is (it happened to me and CONFIG_LEGACY_PTYS is `n' in my
> case),  that ssh tries to open /dev/tty and fails and ends up trying to use
> ssh-askpass (some other way to ask for password).
> 
> But I am still not sure how CONFIG_LEGACY_PTYS=n solves it.
> 
> Change the permissions of /dev/tty to something like 0666 or if you have
> udev, edit the permissions.d/* files
> 
> Please give me your feedback.
> 

 I think when udev creates the ptys nodes dynamically it corrupts the
Legacy ones already create. With CONFIG_LEGACY_PTYS turned off there
never created and udev is free to do what it wants. It could be the
complete reverse though.

By the way th settings in permissions.d are 660 for most things
including ptys. I'm running slackware.

Dan.

