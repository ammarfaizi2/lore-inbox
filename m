Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVEPUTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVEPUTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEPUQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:16:52 -0400
Received: from webmail.topspin.com ([12.162.17.3]:18725 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261857AbVEPUO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:14:59 -0400
To: Greg KH <greg@kroah.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
X-Message-Flag: Warning: May contain useful information
References: <200505132117.37461.arnd@arndb.de>
	<200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 16 May 2005 13:14:58 -0700
In-Reply-To: <20050514074524.GC20021@kroah.com> (Greg KH's message of "Sat,
 14 May 2005 00:45:25 -0700")
Message-ID: <528y2flygt.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 May 2005 20:14:59.0242 (UTC) FILETIME=[EF3C50A0:01C55A53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> No, as Ben said, do not do this.  Use write.  And as you are
    Greg> only doing 1 type of ioctl, it shouldn't be an issue.  Also
    Greg> it will be faster than the ioctl due to lack of BKL usage :)

This is no longer true.  ioctls don't have to take the BKL now that
struct file_operations has unlocked_ioctl and compat_ioctl.

 - R.
