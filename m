Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWGHUvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWGHUvM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWGHUvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:51:12 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:53906 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030376AbWGHUvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:51:11 -0400
Date: Sat, 8 Jul 2006 22:50:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Use target filename in BUG_ON and friends
Message-ID: <20060708205053.GA13124@mars.ravnborg.org>
References: <20060708084713.GA8020@mars.ravnborg.org> <p73sllcnqlk.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73sllcnqlk.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 04:00:55PM +0200, Andi Kleen wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> > 
> > If gcc could be teached not to use full path for __FILE__ this would be
> > an even better fix, but with current make O=.. support I have not found a
> > way to do so.
> 
> I suppose you could ask the gcc people? 
This is more a kbuild issue. gcc supply the filename given on the
commandline and when using vpath support in make the input files have
absolute path resulting in gcc using absolute paths to __FILE__.
The only real fix I think would be to teach kbuild to use
top-og-source-tree as root when building the kernel. And that will break
a lot if this is changed.

	Sam
