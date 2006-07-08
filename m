Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWGHU50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWGHU50 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWGHU50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:57:26 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:27062 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030329AbWGHU50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:57:26 -0400
Date: Sat, 8 Jul 2006 22:57:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Milton Miller <miltonm@bga.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Use target filename in BUG_ON and friends
Message-ID: <20060708205707.GB13124@mars.ravnborg.org>
References: <20060708084713.GA8020@mars.ravnborg.org> <b2ab6d298877aff62aa61e0430a16d3d@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ab6d298877aff62aa61e0430a16d3d@bga.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 11:45:49AM -0500, Milton Miller wrote:
> 			
> On Jul 8, 2006, at 04:45:54 EST, Sam Ravnborg wrote:
> > When building the kernel using make O=.. all uses of __FILE__ becomes
> > filenames with absolute path resulting in increased text size.
> > Following patch supply the target filename as a commandline define
> > KBUILD_TARGET_FILE="mmslab.o"
> 
> Unfortunately this ignores the fact that __LINE__ is meaningless
> without __FILE__ because there are way too many BUGs in header
> files.

__LINE__ gives a very precise hint of the offending .h file.
For x86_64 there are only one line-number clash in include/ for uses of
__FILE__.

"git grep -n __FILE__ | grep line-number" is your friend.

	Sam
