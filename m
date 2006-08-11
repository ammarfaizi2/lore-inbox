Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWHKNKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWHKNKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWHKNKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:10:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:34401 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750773AbWHKNKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:10:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kRuVwkdgRRt4w7IDf7qXpQ4NwaiGrzuo15CoZ0Gcmng3z14AIkfbh5Y6oXCI5xeExvb7NuulAqwm56FmVGAyXbdVHfJppY4c7pfsO25Jm6PEpWPxsnpJdLyqRI93f/9+ay182tfhpFbnRJBL3VPeKRwxq2mpyx/LnZ1tE9OXOBE=
Message-ID: <d120d5000608110610w7c48f760kf954df0e70d738e0@mail.gmail.com>
Date: Fri, 11 Aug 2006 09:10:32 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch 6/6] Move per-device data out of backlight_properties
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1155300957.19959.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.655659401.dtor@insightbb.com>
	 <1155283327.6354.6.camel@localhost.localdomain>
	 <d120d5000608110527q142a727ex5c2223a9aed5aeaa@mail.gmail.com>
	 <1155300957.19959.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Fri, 2006-08-11 at 08:27 -0400, Dmitry Torokhov wrote:
> > On 8/11/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> > > Thinking about this, ideally, struct backlight_properties would be left
> > > containing the backlight properties in but become part of struct
> > > backlight_device (and allocated with it).
> >
> > Why would you want to separate properties into a structure? You don't
> > normally pass a set of properties around so I am not sure why would we
> > need this...
>
> The structure would just end up being optimised away by the compiler so
> would just serve to keep the properties themselves separate from the
> device data. I'm not so bothered about that but don't really want a
> struct backlight_properties around which just contains what would be
> better called something like struct backlight_ops. The backlight core
> has changed a fair bit and the names are starting to lose meaning.
>

There is some constant shared data, such as max_brightness, etc, that
is still residing in backlist_poperties so _ops would not be quite
correct.

-- 
Dmitry
