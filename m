Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422807AbWJNSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbWJNSzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422812AbWJNSzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:55:35 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:7858 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1422815AbWJNSze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:55:34 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 2/2] 2.6.19-rc1-mm1 pktcdvd: bio write congestion
References: <op.thfa4wnqiudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Oct 2006 20:55:16 +0200
In-Reply-To: <op.thfa4wnqiudtyh@master>
Message-ID: <m3u026g223.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> Hello,
> 
> this adds a bio write queue congestion control
> to the pktcdvd driver with fixed on/off marks.
> It prevents that the driver consumes a unlimited
> amount of write requests.

Thanks, this looks good in principle, but I think it can be
implemented in a simpler way.

Jens, can I please ask your opinion. Would it make sense to export the
clear_queue_congested() and set_queue_congested() functions in
ll_rw_blk.c so that the pktcdvd driver can use them? Something like
this patch from a few years ago:

        http://marc.theaimsgroup.com/?l=linux-kernel&m=109378210610508&w=2

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
