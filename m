Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932332AbWFDXuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWFDXuo (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWFDXuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:50:44 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:36737 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932332AbWFDXun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:50:43 -0400
Date: Mon, 5 Jun 2006 01:50:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: clocksource
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606050141120.17704@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 4 Jun 2006, Andrew Morton wrote:

> time-use-clocksource-infrastructure-for-update_wall_time.patch

I still disagree with the update_wall_time() changes, they should be kept 
the new separate from this. The error algorithm is a somewhat old version 
and can cause oscillation and thus a confused clock.

> time-let-user-request-precision-from-current_tick_length.patch

This is broken, as it simply throws away resolution depending on the 
clock.

These are two key problems, the rest can be fixed incrementally.

bye, Roman
