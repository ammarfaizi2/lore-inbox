Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVBBXTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVBBXTC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVBBXPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:15:24 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14584 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262693AbVBBXLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:11:04 -0500
Date: Wed, 2 Feb 2005 16:11:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Bryan O'Donoghue" <typedef@eircom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppc32 2.6.x builds for ppc m8xx arch.
Message-ID: <20050202231102.GG15359@smtp.west.cox.net>
References: <41ED2DAC.5030209@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ED2DAC.5030209@eircom.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 03:39:24PM +0000, Bryan O'Donoghue wrote:

> Greetings list.
> 
> I'm curious about something which looks like an error in the mpc8xx 
> build of the latest 2.6.11-rc1 kernel.
[snip]
> Looking at the difference between the 2.4 and the 2.6 build arguments.
[snip]
> I notice that for a start -m32 has appeared out of nowhere and 

-m32 is what allows you to use a ppc32/64 bi-arch toolchain and build a
32bit kernel.  It is harmless on just ppc32 compilers.

> furthermore -mcpu=860 has gone away.

Correct.  -mcpu860 was a 'do nothing' flag.  It didn't actually tell the
compiler anything, it just didn't cause an error.  It was removed when
we had to add more really used flags.

-- 
Tom Rini
http://gate.crashing.org/~trini/
