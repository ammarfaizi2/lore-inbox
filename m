Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbUFBQxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUFBQxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUFBQxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:53:46 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:31977 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S263612AbUFBQxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:53:36 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Possible bug: ext3 misreporting filesystem usage
Date: Wed, 2 Jun 2004 16:53:34 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c9l0me$cf1$1@news.cistron.nl>
References: <1275157.LnyMtzroWT@ironfroggy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1086195214 12769 62.216.29.200 (2 Jun 2004 16:53:34 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1275157.LnyMtzroWT@ironfroggy.com>,
Calvin Spealman  <calvin@ironfroggy.com> wrote:
>I've been getting a possible bug after running my system a few weeks. The
>ext3 partition's usage is being misreported. Right now, df -h says ive got
>no space left, but according to du /, I'm only using 17 gigs of my 40 gig
>drive. Restarting fixes the problem, so I'm thinking it might be some
>mis-handled variable in memory, not something on the disc itself? And, yes,
>I do know that du is right, not df, because I keep good track of my disc
>usage. This is pretty serious, it killed a 40+ hour process that i'll have
>to start over again from the beginning!

There's a process holding on to a 23 GB logfile that has been
deleted. Try "ls -l /proc/*/fd/* 2>&1 | grep deleted" . Kill the
process and you'll have your space back.

Mike.

