Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVENCns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVENCns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 22:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVENCns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 22:43:48 -0400
Received: from science.horizon.com ([192.35.100.1]:7722 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262684AbVENCnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 22:43:46 -0400
Date: 14 May 2005 02:43:46 -0000
Message-ID: <20050514024346.18045.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan the Hirsute spake unto the masses:
> All non-shite quality flash keys have an on media log structured file
> system and will take 100,000+ writes per sector or so. They decent ones
> also map out bad blocks and have spares. The "wear out the same sector"
> stuff is a myth except on ultra-crap devices.

I would have though so, but I can say from personal experience that
SanDisk brand CF cards respond to losing power during a write by producing
a bad sector.  I had assumed that a sensible implementation would take
advantage of the out-of-place writing by doing a two-phase commit at
write time, so writes would be atomic.

Does anyone know of a CF manufacturer that *does* guarantee atomic writes?
Obviously, if power is lost during a write, it's not clear whether
I'll get the old or the new contents, but I want one or ther other and
not -EIO.

Given that SanDisk first developed the CompactFlash card, you'd think they'd
be a fairly reputable brand...
