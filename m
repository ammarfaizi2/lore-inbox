Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263622AbUJ2Vr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbUJ2Vr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUJ2Vp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:45:27 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43393 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263606AbUJ2V3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:29:04 -0400
Date: Fri, 29 Oct 2004 23:28:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hans Reiser <reiser@namesys.com>
cc: Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Timo Sirainen <tss@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
In-Reply-To: <4182B2FF.9040902@namesys.com>
Message-ID: <Pine.LNX.4.53.0410292326300.8389@yvahk01.tjqt.qr>
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org>
 <20041028093426.GB15050@merlin.emma.line.org> <20041028114413.GL1343@schnapps.adilger.int>
 <4182B2FF.9040902@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Matthias is right.  readdir is badly architected, and no one has fixed
>it for ~30 years.

As long as M$ windows has the same problem, it's justified that we have that
problem for 30 years now.

>It should be possible to perform an atomic readdir if that is what you
>want to do and if you have space in your process to stuff the result.

How much would it cost to always append the new name into the directory rather
than modifying it in place? OTOH, especially Reiserfs does not use linear file
lists, so it would get tricky.

