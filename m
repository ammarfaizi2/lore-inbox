Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWBIXMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWBIXMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWBIXMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:12:45 -0500
Received: from quechua.inka.de ([193.197.184.2]:60605 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750818AbWBIXMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:12:45 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: RSS Limit implementation issue
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F7Kxv-0005u2-00@calista.inka.de>
Date: Fri, 10 Feb 2006 00:12:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Gupta <ram.gupta5@gmail.com> wrote:
> planning to make a check for rss limit when setting up pte. If the
> limit is crossed I see couple of  different ways of handling .
> 
> 1. Kill the process . In this case there is no swapping problem.

This signal would happen on random page access, right?

> 2. Dont kill the process but dont allocate the memory & do yield as we
> do for init process. Modify the scheduler not to chose the process
> which has already allocated rss upto its limit.

Yes, that behaviour looks good. That would keep the system responsive.
Basically the same state as waiting for a page to be paged in.

(However a user based rss limit would be more interesting than process
based)

Gruss
Bernd
