Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUCKVmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUCKVmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:42:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1461 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261746AbUCKVm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:42:27 -0500
Date: Thu, 11 Mar 2004 21:43:54 +0000
From: Joe Thornber <thornber@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Mickael Marchand <marchand@kde.org>, linux-kernel@vger.kernel.org,
       dm@uk.sistina.com
Subject: Re: 2.6.4-mm1
Message-ID: <20040311214354.GM18345@reti>
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311144829.GA22284@colin2.muc.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 03:48:29PM +0100, Andi Kleen wrote:
> Maybe they have broken data structures again, most likely
> because of different long long alignment. A lot of people
> who attempt to design data structures that don't need translation
> get that wrong unfortunately.

I'd thought we'd been careful about this.  You're suggesting that the
size of this structure has changed between kernel versions ?!

struct dm_ioctl {
        uint32_t version[3];
        uint32_t data_size;

        uint32_t data_start;

        uint32_t target_count;
        int32_t open_count;
        uint32_t flags;
        uint32_t event_nr;
        uint32_t padding;

        uint64_t dev;

        char name[DM_NAME_LEN];
        char uuid[DM_UUID_LEN];
};

- Joe
