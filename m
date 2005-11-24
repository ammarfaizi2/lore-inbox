Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbVKXMM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbVKXMM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbVKXMM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:12:56 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:21660 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161028AbVKXMM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:12:56 -0500
Subject: Re: 2.6.14-rt4: via DRM errors
From: Lee Revell <rlrevell@joe-job.com>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>,
       "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
In-Reply-To: <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>
References: <1132807985.1921.82.camel@mindpipe>
	 <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 24 Nov 2005 05:49:38 -0500
Message-Id: <1132829378.3473.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 10:52 +0100, Thomas Hellström wrote:
> I made a fix to the locking code in main drm a couple of months ago.
> 
> The X server tries to get the DRM_QUIESCENT lock, but when the wait
> was interrupted by a signal (like when you move a window around), the
> locking function returned without error. This made the X server
> release other clients' locks.
> 
> This does affect all drivers with a quiescent() function. Not only
> via.
> 
> But it looks like this fix never made it into the kernel source? 

Thanks.

BTW can you point me to a good explanation of DRM locking?  There's so
much indirection in the DRM code I can't even tell whether there's one
DRM lock or several, what kind of lock it is or what it's protecting
(beyond "access to the hardware").  Is it just an advisory lock used by
DRM clients to keep from stepping on each other?  It doesn't seem
related to spinlocks or mutexes or any of the other types of lock in the
kernel.

Lee



