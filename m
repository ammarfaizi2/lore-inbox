Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWHHMu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWHHMu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWHHMu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:50:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36871 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932457AbWHHMuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:50:14 -0400
Date: Tue, 8 Aug 2006 12:08:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 06/12] hdaps: Limit hardware query rate
Message-ID: <20060808120839.GD4540@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <1154849268493-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154849268493-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The current hdaps driver queries the hardware on (almost) any sysfs read.
> Since fresh readouts are genereated by the hardware at a constant rate,
> this means apps are eating each other's events. Also, polling multiple
> attributes will genereate excessive hardware queries and excessive CPU
> load due to the duration of the hardware query transaction.
> 
> With this patch, the driver will normally update its cached readouts
> only in its timer function (which exists anyway, for the input device).
> If that read failed, it will be retried upon the actual sysfs access.
> In all cases, query rate is bounded and apps will get reasonably
> fresh and usually cached readouts.
> 
> The polling rate is increased to 50Hz, as needed by the hdaps daemon.
> A later patch makes this configurable.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

I'd insert fewer blank lines, otherwise patch looks ok to me.

Signed-off-by: Pavel Machek <pavel@suse.cz>

-- 
Thanks for all the (sleeping) penguins.
