Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWHKM4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWHKM4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 08:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWHKM4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 08:56:08 -0400
Received: from tim.rpsys.net ([194.106.48.114]:22681 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932208AbWHKM4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 08:56:07 -0400
Subject: Re: [patch 6/6] Move per-device data out of backlight_properties
From: Richard Purdie <rpurdie@rpsys.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000608110527q142a727ex5c2223a9aed5aeaa@mail.gmail.com>
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.655659401.dtor@insightbb.com>
	 <1155283327.6354.6.camel@localhost.localdomain>
	 <d120d5000608110527q142a727ex5c2223a9aed5aeaa@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 13:55:57 +0100
Message-Id: <1155300957.19959.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 08:27 -0400, Dmitry Torokhov wrote: 
> On 8/11/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> > Thinking about this, ideally, struct backlight_properties would be left
> > containing the backlight properties in but become part of struct
> > backlight_device (and allocated with it).
> 
> Why would you want to separate properties into a structure? You don't
> normally pass a set of properties around so I am not sure why would we
> need this...

The structure would just end up being optimised away by the compiler so
would just serve to keep the properties themselves separate from the
device data. I'm not so bothered about that but don't really want a
struct backlight_properties around which just contains what would be
better called something like struct backlight_ops. The backlight core
has changed a fair bit and the names are starting to lose meaning.

Richard


