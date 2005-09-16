Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVIPWpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVIPWpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVIPWpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:45:19 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:57324 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750735AbVIPWpS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:45:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GsZ3DruISiOUnLPoM1ceuXsba6qnH+CXsg0iHuspPvuNv4UCyMn/VvteIcSq5KQArCSTIxOqq0kQQvTHyW/6znLul61eP+ncWvTv+IWP/CQi/fd5Rc79xfM/Nnk8tuptdeZsrFx4ItGwaAqQHjkUvc4wwOToUQKcD+PPAd6WsQM=
Message-ID: <d120d50005091615455e6c1181@mail.gmail.com>
Date: Fri, 16 Sep 2005 17:45:16 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
In-Reply-To: <20050916215557.GE13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org>
	 <20050916215557.GE13920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Greg KH <gregkh@suse.de> wrote:
> On Fri, Sep 16, 2005 at 03:04:38AM +0200, Kay Sievers wrote:
> > How will the SUBSYSTEM (kset name) value look like for a "subclass"?
> 
> It would be the CLASS value, to make it easier for userspace.
> 
> > Will it have it's own value or will all class devices and subclass
> > devices share the same SUBSYSTEM?
> 
> Yes, they will all share the same.
> 
> > What are the "subclass drivers"? Similar to the current "bus drivers"?
> 
> No, kinda like what the mouse driver is today.  It's a type of driver
> that creates subclass devices for class devices.
> 
> > Will it be possible to have subclasses of subclasses? :)
> 
> Heh, no, the tree stops here :)
> 

I think you are potentially shooting yourself in the foot. There is no
technical reasons for limiting depth of the tree.

-- 
Dmitry
