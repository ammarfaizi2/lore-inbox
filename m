Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbUKXHkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUKXHkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUKXHi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:38:26 -0500
Received: from colino.net ([213.41.131.56]:7413 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262530AbUKXHgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:36:09 -0500
Date: Wed, 24 Nov 2004 08:34:30 +0100
From: Colin Leroy <colin@colino.net>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124083430.5cf5d621@pirandello>
In-Reply-To: <20041124031726.GF8040@waste.org>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<20041124031726.GF8040@waste.org>
X-Mailer: Sylpheed-Claws 0.9.12cvs163.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 2004 at 19h11, Matt Mackall wrote:

Hi, 

> BUG_ON(!bh);
> sync_dirty_buffer(bh);
> brelse(bh);

I wasn't sure sync_dirty_buffer and brelse checked for nullity :)

> Concept seems good, and the implementation otherwise looks good at
> first glance.

Cool :) Should I submit an updated patch to Andrew for -mm ?

Thanks for all the comments. I agree with what most people said, sync
mode is not a guarantee that everything will be fine, but it helps in
most cases.

As for the speed, from what I checked it slows down IO a bit, of course,
but that is within tolerable bounds imho. 
-- 
Colin
