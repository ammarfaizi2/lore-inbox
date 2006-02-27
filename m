Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWB0H3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWB0H3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWB0H3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:29:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751638AbWB0H3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:29:15 -0500
Date: Mon, 27 Feb 2006 02:28:44 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060227072844.GA15638@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 09:27:28PM -0800, Linus Torvalds wrote:

 > Have I missed anything? Holler. And please keep reminding about any 
 > regressions since 2.6.15.

We seem to have a nasty bio slab leak.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183017
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182970

Two seperate reports, both using raid1, sata_via and firewire
Curiously, they're both on x86-64 too.

Will keep an eye open for other reports of this as they come in.

(The kernels they mention in those reports are fairly recent.
 2.6.15-1.1977_FC5 is ctually based on 2.6.16rc4-git6)

		Dave


