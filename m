Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWCCKeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWCCKeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCCKeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:34:11 -0500
Received: from mx03.kontent.de ([81.88.34.122]:58812 "EHLO MX03.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751477AbWCCKeK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:34:10 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Fri, 3 Mar 2006 11:34:10 +0100
User-Agent: KMail/1.8
Cc: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <200603012242.35633.rene@exactcode.de> <200603012259.26790.baldrick@free.fr>
In-Reply-To: <200603012259.26790.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603031134.10638.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. März 2006 22:59 schrieb Duncan Sands:
> > So, queing alot URBs is the recommended way to sustain the bus? Allowing
> > way bigger buffers will not be realistic?
> 
> usbfs could copy the user buffer to a bunch of non-contiguous pages, and
> then fire those off in an urb using the scatter-gather stuff.  [Rather than,
> as now, allocating a bunch of contiguous pages using kmalloc].  That would
> probably make it possible to use much much bigger user-space buffers.  Plus
> the code looks rather easy to write.

It seems to me that that would change the API. The scatter/gather stuff
can fail partially, can't it?

	Regards
		Oliver
