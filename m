Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUCRWh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCRWh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:37:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5830 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263003AbUCRWh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:37:57 -0500
Date: Thu, 18 Mar 2004 22:37:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
In-Reply-To: <20040318221447.GA3248@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403182234090.16863-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Andrea Arcangeli wrote:
> 
> The fix is simple: always set and clear PG_anon under the page_map_lock,
> this will avoid the race since all ClearPageAnon already runs under the
> page_map_lock. I will implement and test in a few hours.
> 
> ... I find this more robust.

Absolutely, that's what I did too.  My old page_add_rmap had anon flag,
but the new patches have page_add_anon_rmap and page_add_obj_rmap.

Hugh

