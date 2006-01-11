Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWAKVvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWAKVvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWAKVvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:51:48 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:27043 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751063AbWAKVvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:51:47 -0500
Date: Wed, 11 Jan 2006 21:50:31 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Dave Jones <davej@redhat.com>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
In-Reply-To: <20060111202957.GA3688@redhat.com>
Message-ID: <Pine.LNX.4.58.0601112149270.8371@skynet>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org>
 <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org>
 <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > How are we supposed to get DRM to work on PCI Express cards if DRM needs
>  > AGP and agpgart does not load when no AGP card is found ? :)
>  >
>  > drm: Unknown symbol agp_bind_memory
>  > ...
>  > drm: Unknown symbol agp_backend_release
>  > radeon: Unknown symbol drm_open
>  > ...
>  > radeon: Unknown symbol drm_release
>
> That's puzzling. It should still be loadable. All the current agpgart tree
> is doing is basically enforcing agp=off if there's no agp card present.
> That shouldn't prevent the module from actually loading, or it's symbols being
> referenced by other modules.
>
> Hrmm, it's puzzling that you also are unable to resolve drm_open and drm_release.
> That may be a follow-on failure from the first, but it seems unlikely.
>
> DaveA, any clues ?

Thats' just a cascaded failure, radeon gives out because drm won't load
because agpgart won't load... there must be a reason why agpgart doesn't
load... perhaps we've some issue when the backend isn't there or
something..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

