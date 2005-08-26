Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVHZUM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVHZUM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVHZUM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 16:12:27 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:7895 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030255AbVHZUM0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 16:12:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tpRJ0Rhc210jLa5yqlmCEJhoRptykClTSzvoNW8Gym5pGWDAZiIrPZlNdCBs0CLOMaJsJ1narV6RSd94llie0n4B3zYLUAaKrvmgT/hD23Qr5DisNg/C4cRUTG8c91ST4UAi/5lKCUO12p3crCg3neJdk5iTpzwsbvbnAcia+uE=
Message-ID: <d120d50005082613122595cde8@mail.gmail.com>
Date: Fri, 26 Aug 2005 15:12:25 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Robert Love <rml@novell.com>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125085141.18155.97.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125069494.18155.27.camel@betsy>
	 <d120d500050826122768cd3612@mail.gmail.com>
	 <1125085141.18155.97.camel@betsy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Robert Love <rml@novell.com> wrote:
> On Fri, 2005-08-26 at 14:27 -0500, Dmitry Torokhov wrote:
> 
> > What this completion is used for? I don't see any other references to it.
> 
> It was the start of the release() routine, but I decided to move to
> platform_device_register_simple() and use its release, instead.  So this
> is gone now in my tree.
> 
> > I'd rather you used absolute coordinates and set up
> > hdaps_idev->absfuzz to do the filtering.
> 
> Me too.
> 

Btw, if you set up absolute input device it will be claimed by joydev
instead of mousedev and will not get in a way of normal operation
while still available for playing. So you could just kill all that
enabling/disabling code and have input device always activated.

> >
> > What about using sysfs_attribute_group?
> 
> I don't see this in my tree?

Sorry, it is called struct attribute_group, sysfs_create_group() and
sysfs_remove_group(). See fs/sysfs/group.c

-- 
Dmitry
