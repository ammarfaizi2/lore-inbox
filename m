Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbVKYPvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbVKYPvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbVKYPvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:51:48 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47781 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161125AbVKYPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:51:47 -0500
Subject: Re: 2.6.14-rt4: via DRM errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>,
       "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
In-Reply-To: <1132829378.3473.11.camel@mindpipe>
References: <1132807985.1921.82.camel@mindpipe>
	 <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>
	 <1132829378.3473.11.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2005 16:24:23 +0000
Message-Id: <1132935863.3298.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-24 at 05:49 -0500, Lee Revell wrote:
> BTW can you point me to a good explanation of DRM locking?  There's so
> much indirection in the DRM code I can't even tell whether there's one
> DRM lock or several, what kind of lock it is or what it's protecting
> (beyond "access to the hardware").  Is it just an advisory lock used by
> DRM clients to keep from stepping on each other?  It doesn't seem
> related to spinlocks or mutexes or any of the other types of lock in the
> kernel.

It co-ordinates access between the X server and various 3D clients so
that they don't step on each others drawing. A shared memory area is
used to co-ordinate other things like clip lists and what context may
have been stomped by another user if when you retake the lock you were
not last holder.

Precisely what it protects is board dependant

