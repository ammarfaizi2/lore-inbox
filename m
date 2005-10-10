Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVJJVjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVJJVjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVJJVjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:39:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51177 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751270AbVJJVji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:39:38 -0400
Date: Mon, 10 Oct 2005 23:39:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/16] GFS: core fs
Message-ID: <20051010213928.GB2475@elf.ucw.cz>
References: <20051010171002.GD22483@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010171002.GD22483@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Signed-off-by: Ken Preslan <ken@preslan.org>
> Signed-off-by: David Teigland <teigland@redhat.com>

> +	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {

> +		for (head = &ai->ai_ail1_list, tmp = head->prev, prev = tmp->prev;
> +		     tmp != head;
> +		     tmp = prev, prev = tmp->prev) {


> +	for (head = &ai->ai_ail1_list, tmp = head->prev, prev = tmp->prev;
> +	     tmp != head;
> +	     tmp = prev, prev = tmp->prev) {


Can you get less creative in the for loops? [There are more examples
at other patches, for (i=something; i--; ) was "nicest" example].

> +		for (;;) {

while(1) seems to be more common in kernel.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
