Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWCGXha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWCGXha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWCGXh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:37:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:29608 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964808AbWCGXh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:37:29 -0500
X-Authenticated: #428038
Date: Wed, 8 Mar 2006 00:37:24 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Silviu Marin-Caea <silviu_marin-caea@fieldinsights.ro>,
       opensuse-factory@opensuse.org, linux-kernel@vger.kernel.org
Subject: Re: [opensuse-factory] Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060307233724.GB13357@merlin.emma.line.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Silviu Marin-Caea <silviu_marin-caea@fieldinsights.ro>,
	opensuse-factory@opensuse.org, linux-kernel@vger.kernel.org
References: <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de> <200603070942.31774.silviu_marin-caea@fieldinsights.ro> <1141769422.767.99.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141769422.767.99.camel@mindpipe>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006, Lee Revell wrote:

> If they are doing serious realtime DSP then they should get better
> results in userspace anyway, because they get to use the floating point
> unit which isn't allowed in the kernel.

It's not as though every algorithm needed float just because it said DSP
(some of those are actually fixed-point or something like that) at a time.

There are lots of algorithms to avoid exactly that, because it costs
performance big time. Whenever you can have integer and/or
reduce/approximate multiplication by shift+add, people will use it if
performance is of paramount importance. And such often is the difference
between having a real-time DRM software radio or not, to name just one
example I've seen in my vicinity.

In a color-space conversion tool (CCITT YUV to RGB) on P-II or P-III
(don't recall) emulating fixed point by using integers and then shifting
appropriately gave a speedup of well more than three.

There must surely be better and reasons than the FPU - licenses had
already been mentioned.

-- 
Matthias Andree
