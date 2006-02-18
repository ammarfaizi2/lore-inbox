Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWBRWis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWBRWis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWBRWis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:38:48 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:40977 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932244AbWBRWir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:38:47 -0500
Date: Sat, 18 Feb 2006 23:38:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild:
Message-ID: <20060218223835.GA21068@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <p73y80848qb.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y80848qb.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 11:12:28PM +0100, Andi Kleen wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > I have moved the functionality of reference_init + reference_discarded
> > to modpost to secure a much wider use of this check.
> 
> How much does that slow the build down?
It obviously depends on number of modules / size of vmlinux.
With x86_64 and defconfig + all oss drivers configured as modules the
modpost stage takes around 0.2 sec in total. So this is down in the
noise level. Building allmodconfig kernel atm and if I see > 2 sec
difference with and without the check I will do a follow-up post.

Obviously the more modules with problems the longer time. So I will
skip the warning messages in the measurements since I assume they will
be taken care of.

	Sam
