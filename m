Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSG3XcO>; Tue, 30 Jul 2002 19:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317406AbSG3XcO>; Tue, 30 Jul 2002 19:32:14 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:44551 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317405AbSG3XcO>; Tue, 30 Jul 2002 19:32:14 -0400
Date: Wed, 31 Jul 2002 01:35:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Greg KH <greg@kroah.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <200207302312.g6UNC7Z10529@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0207310121470.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 30 Jul 2002, Richard Gooch wrote:

> With your
> "fixups", those drivers will break when "devfs=only" is passed in.

That feature is broken by design already anyway. devfs has absolutely no
business managing that device pointer. You're duplicating code and it only
makes it harder to properly protect it. As far as I can see it's still
broken wrt to module unloading.

bye, Roman

