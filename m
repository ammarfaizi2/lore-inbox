Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVIQBnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVIQBnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIQBnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:43:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:39562 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750820AbVIQBnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:43:21 -0400
Date: Sat, 17 Sep 2005 03:43:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help by KConfig expansion
In-Reply-To: <20050916081221.48974.qmail@web51002.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0509170333040.3743@scrub.home>
References: <20050916081221.48974.qmail@web51002.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Sep 2005, Ahmad Reza Cheraghi wrote:

> That what is written beside the "auto" should save in
> the Component called char *auto in one of the above
> mentioned struct. There must be some changes in the
> file zconf.tab.c. Any Suggestion how to this?? 

You have to modify zconf.l/zconf.y for this and regenerate this file 
(check the Makefile). First you have to define the keywords in zconf.l
and then extend the parser in zconf.y to recognize them and add the data 
to the internal structures.

bye, Roman
