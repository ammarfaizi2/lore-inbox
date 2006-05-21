Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWEUWHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWEUWHm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWEUWHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:07:41 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:11616 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964995AbWEUWHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:07:40 -0400
Date: Sun, 21 May 2006 15:07:38 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ameer Armaly <ameer@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] fs warning fixes
Message-ID: <20060521220738.GA5564@taniwha.stupidest.org>
References: <Pine.LNX.4.61.0605211502450.2255@sg1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605211502450.2255@sg1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 03:03:36PM -0400, Ameer Armaly wrote:

> This patch gets rid of two uninitialized variable warnings by
> initializing idx in fs/bio.c and fd in fs/eventpoll.c; both of these
> are initialized through pointers later on.

> -			unsigned long idx;
> +			unsigned long idx = 0;

[...]

> -	int error, fd;
> +	int error, fd = 0;

Please don't do this unless it really is fixing a bug.  gcc false
warnings are not kernel bugs.
