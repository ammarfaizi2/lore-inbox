Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWADRCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWADRCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWADRCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:02:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932552AbWADRCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:02:31 -0500
Date: Wed, 4 Jan 2006 09:02:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Ulrich Drepper <drepper@redhat.com>, Andi Kleen <ak@suse.de>,
       "Viro, Al" <viro@ftp.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Limit sendfile() to 2^31-PAGE_CACHE_SIZE bytes without
 error
In-Reply-To: <43BB5E22.2010306@zytor.com>
Message-ID: <Pine.LNX.4.64.0601040900311.3668@g5.osdl.org>
References: <43BB348F.3070108@zytor.com> <200601040451.20411.ak@suse.de>
 <Pine.LNX.4.64.0601032051300.3668@g5.osdl.org> <43BB5646.2040504@zytor.com>
 <43BB5E22.2010306@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Jan 2006, H. Peter Anvin wrote:
> 
> (I set the limit to 2^31-PAGE_CACHE_SIZE so that a transfer that starts at the
> beginning of the file will continue to be page-aligned.)

Ok, this patch looks ok, if it's confirmed to unbreak apache.

		Linus
