Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVC3FhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVC3FhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVC3FhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:37:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:59269 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261218AbVC3FhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:37:09 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Aligning file system data
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <424A2BD0.5010609@comcast.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DGVt5-0008CT-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 30 Mar 2005 07:37:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <424A2BD0.5010609@comcast.net> you wrote:
> How likely is it that I can actually align stuff to 31.5KiB on the
> physical disk, i.e. have each block be a track?

It is not that easy to allign on tracks, even on raw partition. Some disks
have different length of tracks (of course because the inner cylinders are
shorter), some show a totally different geometry than they have internally,
and the disks are happyly remapping.

With raid and lvm the situation get worse.

Why do you want to do thoe micro optimizations?

With a filesystem in between you have virtuelly no way to allign larger
files for streaming.

Let the buffer cache and prefetch do, what they are intended for and feel
happy.

Greetings
Bernd
