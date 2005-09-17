Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVIQL6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVIQL6z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 07:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVIQL6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 07:58:55 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:16916 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbVIQL6z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 07:58:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=avpwXckbGHz64NtH5YhFZXL8/wQPU9FzAnUjU7hBKVrprbyZC5WNC/2+0NBJKqVSgmn2E0vTsBew4fVwsVn+0aIalPCG5QTljxdj5X3xqhumDKVJrd5yFHbaolxgkg7Ri6kJUjKPmmBdN37oJSAc3Qu5ZvRDfi3XTkb207LafHA=
Message-ID: <5c43128e0509170458398828fd@mail.gmail.com>
Date: Sat, 17 Sep 2005 13:58:51 +0200
From: Wim Vinckier <wimpunk@gmail.com>
Reply-To: wimpunk@gmail.com
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Trouble hotplugging on embedded system (solved)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0509162210100.12505@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5c43128e050916024110467f02@mail.gmail.com>
	 <Pine.LNX.4.60.0509162210100.12505@poirot.grange>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The solution was pretty easy.  I didn't loaded all the usb drivers I
needed.  After loading uhci_hcd, I got the result I wanted, my devices
were made by devfsd.

wim.

On 9/16/05, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On Fri, 16 Sep 2005, Wim Vinckier wrote:
> 
> > I'm trying to get usb hotplugging working on a embedded system but it
> > doesn't (seem to) work.  As far as i understand all the documents I've
> > read, /sbin/hotplug (depending on /proc/sys/kernel/hotplug) should be
> > called whenever plugging in a device.  I guess I've forgot to enable
> > something in my kernel configuration but I can't find what went wrong.
> >  I've tried 2.6.8 and 2.6.12 with busybox 1.01.
> 
> I think, there are some modifications needed to the hotplug to work with
> busybox. Either in shell script syntax, or something else - can't say
> exactly. Try to google for "hotplug busybox". I think, there was even a
> special version of hotplug for busybox somewhere...
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
>
