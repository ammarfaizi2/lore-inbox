Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVCOUwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVCOUwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVCOUtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:49:39 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:54397 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261897AbVCOUsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:48:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aeKib/mQ3odnO580mkQ7vpgWdviTtLTt+XRY8QTezbylrf292nvY7Kg5beJtbQ8jvEXbcJkVTZLDpsdcZSfX9Dsj3eSxyjpxoxEYl6O+79HOK9O0IBkRABHapD6C+T0tH2GZoruCT2Zsiy2r7R23lO5RZ76H/KCIg9XiWygq0Z8=
Message-ID: <d120d50005031512485125db18@mail.gmail.com>
Date: Tue, 15 Mar 2005 15:48:32 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <200503151235.02934.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050315170834.GA25475@kroah.com>
	 <20050315195121.GA27408@kroah.com>
	 <d120d50005031512143929e39f@mail.gmail.com>
	 <200503151235.02934.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 12:35:02 -0800, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 15 March 2005 12:14 pm, Dmitry Torokhov wrote:
> >
> > It looks to me (and I might be wrong) that USB was never really
> > integrated into the driver model. It was glued with it but the driver
> > model came after most of the domain was defined, and it did not get to
> > be "bones" of the subsystem. This is why it is so easy to deatch it.
> 
> That doesn't seem accurate to me.  Are you thinking maybe about
> just how it uses the class device stuff?  Like the rest of the
> class device support (for all busses!) that did indeed come later.
> You may recall that the first versions of the driver model had
> more or less a big "fixme" where class devices sat...  Or are
> you maybe thinking about peripheral side (not host side) USB?
> 
> But the "struct device" core of the driver model sure looks like
> the bones of USB to me.  Host controllers, hubs, devices, and
> interfaces all use it well, behave well with hot-unplug (which
> is more than many subsystems can say even in 2.6.11!), and even
> handling funky cases like drivers needing to bind to multiple
> interfaces on one device.  That last took quite a while to land,
> it involved ripping out the last pre-driver-model binding code.
> 

David,

I was not criticizing the code, not at all, I was commenting on
evolution of the code (at least the way I perceive it). The fact that
there is (or was until recently) pre-driver-model binding code shows
that merging is still ongoing and this fact makes reversing the
process easier.

-- 
Dmitry
