Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUKHQog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUKHQog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUKHQga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:36:30 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:57563 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261856AbUKHOdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:33:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Lg2//nFxf62tn2tn08kD8YgU+rKhFaAZY5QkuDQEkIWr4o2cdhMk/8QatUNSH6wXBJjDNTE8S/WxQLMcIMAk0m1plqC4Tv7HytVS8pV4iiSNCpIIdJg8G0G4tkvbLHPCQBLu+wX2bySkDYNNA/QLJSIhOYDrFcc6HK/WWdck9Rs=
Message-ID: <d120d50004110806334f69507c@mail.gmail.com>
Date: Mon, 8 Nov 2004 09:33:34 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Juergen Quade <quade@hsnr.de>
Subject: Re: [RFT/PATCH] Toshiba Satellite, Synaptics & keyboard problems
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20041108083531.GA17236@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411080154.54279.dtor_core@ameritech.net>
	 <20041108083531.GA17236@hsnr.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004 09:35:31 +0100, Juergen Quade <quade@hsnr.de> wrote:
> On Mon, Nov 08, 2004 at 01:54:52AM -0500, Dmitry Torokhov wrote:
> > Hi,
> >
> > If anyone experiencing keyboard getting "stuck" when you use Synaptics
> > touchpad in native mode on Toshiba Satellite type notebooks it seems that
> > lowering rate to 40 pps (which is roughly the same as standard PS/2 rate
> > bytewise) helps.
> >
> > Please try the patch below (should apply to -mm tree) and see if it helps
> > any. If not using -mm tree just use "psmouse.rate=40" or "modprobe psmouse
> > rate=40" to check if fix is working for you and let me know.
> 
> I have problems with "no keyboard" since Kernel 2.6.9.
> I am not using a -mm tree and booting with "psmouse.rate=40" does
> _not_ fix the problem :-(   (tested with 2.6.9 and 2.6.10-rc1).
> 
> As soon as X is started I have no keyboard.
> My box is a Acer Travelmate 290 notebook with synaptics/alps
> touchpad.
> 

Well, this one is pretty easy - make sure that you have a recent
version of Synaptics X driver and change protocol in your XF86Config
to "auto-dev". (most likely you wree using /dev/input/exentX as your
device and in 2.6.9 your keyboard and touchpad swapped their
event devices).

-- 
Dmitry
