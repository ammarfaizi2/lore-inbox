Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVBCKev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVBCKev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVBCKev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:34:51 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22191 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262795AbVBCKaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:30:14 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 3 Feb 2005 11:24:35 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Eric Lammerts <eric@lammerts.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix SAA7134 transport stream errors
Message-ID: <20050203102435.GC10602@bytesex>
References: <Pine.LNX.4.58.0502011901020.21364@vivaldi.madbase.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502011901020.21364@vivaldi.madbase.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 08:19:17PM -0500, Eric Lammerts wrote:
> 
> Hi,
> I had a lot of problems with the transport stream input on the
> SAA7134. Even the slighest bit of other system activity caused data
> corruption. This patch corrects the switching of the two DMA
> buffers.

Thanks, merged (and fixed a simliar issue in saa7134-video.c along the
way ;).

> FYI, the problems only occur on Transmeta TM5800/TM5400 Crusoe boards
> (1GHz/533MHz). When I move the SAA7134 board to a 400MHz Celeron, no
> problems at all. I measured the interrupt latency of the SAA7134
> interrupt on the Crusoe, and that peaks to >1000us when power
> management is enabled and other activity (IDE DMA) is taking place!!
> That may explain why other people haven't seen this problem.

It has shown up before already (long ago), thats why the two-buffer
thingy exists in the first place.  Looks like 2.6 really makes a better
job on low-latency than 2.4 did, otherwise that would have been noticed
earlier...

  Gerd

