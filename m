Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289142AbSBDVSK>; Mon, 4 Feb 2002 16:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289030AbSBDVR5>; Mon, 4 Feb 2002 16:17:57 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:31936 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S289142AbSBDVRm>;
	Mon, 4 Feb 2002 16:17:42 -0500
To: Christian Hildner <christian.hildner@hob.de>
Cc: davidm@hpl.hp.com, linux ia64 kernel list <linux-ia64@linuxia64.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] kmalloc() size-limitation
In-Reply-To: <3C3D6A89.27EAA4C7@hob.de> <15421.61910.163437.45726@napali.hpl.hp.com> <3C3ED5E7.8BA479B7@hob.de> <15423.5404.65155.924018@napali.hpl.hp.com> <3C43D6EC.74B4EC85@hob.de>
From: Jes Sorensen <jes@sunsite.dk>
Date: 04 Feb 2002 22:16:41 +0100
In-Reply-To: Christian Hildner's message of "Tue, 15 Jan 2002 08:14:52 +0100"
Message-ID: <d31yg1lzgm.fsf@lxplus052.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hildner <christian.hildner@hob.de> writes:

> David,
> 
> you proposed me to use alloc_pages() instead of kmalloc() in order
> to get memory bigger than the 128K limit of the kmalloc() call. But
> even driver-developers don't want to handle with the page struct
> unless this is unavoidable. Which are the disadvantages of
> increasing the size limit of kmalloc() to 256K, 512K or 1M since
> machines are getting bigger and 64Bit machines break with current
> memory limitations?

Because drivers needs to work on all architectures and relying on
different hahavior from kmalloc() is bad.

Jes
