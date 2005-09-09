Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbVIISPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVIISPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVIISPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:15:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030314AbVIISPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:15:47 -0400
Date: Fri, 9 Sep 2005 11:15:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@ZenIV.linux.org.uk
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [sparse fix] (was Re: [PATCH] bogus cast in bio.c)
In-Reply-To: <Pine.LNX.4.58.0509091047530.3051@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509091114300.3051@g5.osdl.org>
References: <20050909155356.GF9623@ZenIV.linux.org.uk> <je4q8u1agp.fsf@sykes.suse.de>
 <20050909163643.GO9623@ZenIV.linux.org.uk> <20050909172938.GQ9623@ZenIV.linux.org.uk>
 <Pine.LNX.4.58.0509091047530.3051@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Sep 2005, Linus Torvalds wrote:
> 
> Ack. Applied,

Btw, I also just committed the fix to not warn for

	#if defined(TOKEN) && TOKEN > 1

when TOKEN is undefined and -Wundef is enabled. Implemented exactly the
way you suggested.

		Linus
