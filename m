Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVASJ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVASJ7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVASJ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:59:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:42696 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261652AbVASJ7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:59:36 -0500
Message-ID: <41EE2F82.3080401@suse.de>
Date: Wed, 19 Jan 2005 10:59:30 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
References: <41ED2457.1030109@suse.de> <d120d50005011807566ee35b2b@mail.gmail.com>
In-Reply-To: <d120d50005011807566ee35b2b@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi,
> 
> On Tue, 18 Jan 2005 15:59:35 +0100, Hannes Reinecke <hare@suse.de> wrote:
> 
>>Implement proper class names for input drivers.
>>
> 
> 
> This patch probably should probably use atomic_inc in case we ever
> have non-serialized probe functions.
> 
True.

> But the real question is whether we really need class devices have
> unique names or we could do with inputX thus leaving individual
> drivers intact and only modifying the input core. As far as I
> understand userspace should be concerned only with device
> capabilities, not particular name, besides, it gets PRODUCT string
> which has all needed data encoded.
> 
Indeed. What about using 'phys' (with all '/' replaced by '-') as the 
class_id? This way we'll retain compability with /proc/bus/input/devices 
and do not have to touch every single driver.

Better idea?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
