Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317713AbSGVR0A>; Mon, 22 Jul 2002 13:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317724AbSGVR0A>; Mon, 22 Jul 2002 13:26:00 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7044 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317713AbSGVR0A>; Mon, 22 Jul 2002 13:26:00 -0400
Date: Mon, 22 Jul 2002 11:28:46 -0600
Message-Id: <200207221728.g6MHSkY15219@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 devfs
In-Reply-To: <3D3BE1DD.3040803@evision.ag>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
	<3D3BE1DD.3040803@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki writes:
> Kill two inlines which are notwhere used and which don't make sense
> in the case someone is not compiling devfs at all.

Rejected. Linus, please don't apply this bogus patch. External patches
and drivers rely on the inline stubs so that #ifdef CONFIG_DEVFS_FS
isn't needed.

Martin, why are you bothering with this kind of false cleanup? These
inline stubs don't take up any space in the object files, so why
bother? Also, given that the stubs were carefully added in the first
place, it suggests that there is a good reason for their presence.

Why didn't you stop and think it through before firing off a patch, or
at least ask me if you couldn't see why? This "patch first, think/ask
questions later" approach is disturbing.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
