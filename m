Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVCDQVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVCDQVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVCDQVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:21:17 -0500
Received: from vawad.err.no ([129.241.93.49]:32714 "EHLO vawad.err.no")
	by vger.kernel.org with ESMTP id S261450AbVCDQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:21:14 -0500
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
From: Hans-Christian Egtvedt <hc@mivu.no>
To: linux-kernel@vger.kernel.org
Cc: dtor_core@ameritech.net
In-Reply-To: <d120d50005030406525896b6cb@mail.gmail.com>
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no>
	 <200503041403.37137.adobriyan@mail.ru>
	 <d120d50005030406525896b6cb@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: MIVU Solutions DA
Date: Fri, 04 Mar 2005 17:20:24 +0100
Message-Id: <1109953224.3069.39.camel@charlie.itk.ntnu.no>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 09:52 -0500, Dmitry Torokhov wrote:
> On Fri, 4 Mar 2005 14:03:37 +0200, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> > On Friday 04 March 2005 12:30, Hans-Christian Egtvedt wrote:

<snip info about kref>

> As far as the driver goes:
> 
> - yes, it does need input_sync;

One problem with input_sync is that the panel get's too fast, and double
click is experienced quite often, maybe some threshold is needed for low
values in Z-direction?

I'm probably doing something wrong here since I experience easy
doubleclicks when I just lightly touch the screen.

> - I prefer using input_set_abs_params instead of setting mix, max,
> flat and fuzz for each axis manually;

Thanks, I've adopted to those now, havn't had time to test with the
panel today, but my guess is that this dosn't make a big deal.

> - I believe "/* .. */" is preferred over "//"

Done.

> - kill the commented out bad prototypes.

Done.

> Also, is there a way to query the screen for actual size?

Sorry, the panel is a fixed size, and it gives out coordinates from 0 ->
4095 in both X- and Y-direction. In Z-direction (pressure strength) it
goes from 0 to 255.

Or did you want the size of the screen? Meaning you want to know if it's
a 15", 17" and so on?

-- 
Hans-Christian Egtvedt <hc@mivu.no>
MIVU Solutions DA
