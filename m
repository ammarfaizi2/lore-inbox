Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262114AbREXPwg>; Thu, 24 May 2001 11:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262115AbREXPw0>; Thu, 24 May 2001 11:52:26 -0400
Received: from geos.coastside.net ([207.213.212.4]:4011 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262114AbREXPwL>; Thu, 24 May 2001 11:52:11 -0400
Mime-Version: 1.0
Message-Id: <p05100301b732c8715ebd@[207.213.214.37]>
In-Reply-To: <20010524103145.A9521@gruyere.muc.suse.de>
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au>
 <200105240658.f4O6wEWq031945@webber.adilger.int>
 <20010524103145.A9521@gruyere.muc.suse.de>
Date: Thu, 24 May 2001 08:50:04 -0700
To: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Dying disk and filesystem choice.
Cc: monkeyiq <monkeyiq@users.sourceforge.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:31 AM +0200 2001-05-24, Andi Kleen wrote:
>reiserfs doesn't, but the HD usually has transparently in its firmware.
>So it hits a bad block; you see an IO error and the next time you hit
>the block the firmware has mapped in a fresh one from its internal
>reserves.

Drives have remapping capability, but it's the first I've heard of HD 
firmware doing it automatically. I'd be very interested in reading 
the relevant documentation, if you could provide a pointer. Seems to 
me if a drive *could* do this, you'd certainly want to turn it 
(automatic remapping) off. There's way too much chance that a system 
will read the remapped sector and assume that it contains the 
original data. That would be hopelessly corrupting.
-- 
/Jonathan Lundell.
