Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWAFTr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWAFTr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAFTr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:47:56 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:41228 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964800AbWAFTrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:47:55 -0500
Date: Fri, 6 Jan 2006 20:47:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: Ryan Anderson <ryan@michonline.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git in scripts/setlocalversion
Message-ID: <20060106194735.GA15694@mars.ravnborg.org>
References: <20060104194203.GA2359@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104194203.GA2359@lsrfire.ath.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 08:42:03PM +0100, Rene Scharfe wrote:
> Currently scripts/setlocalversion is a Perl script that tries to figure
> out the current git commit ID of a repo without using git.  It also
> imports Digest::MD5 without using it and generally is too big for the
> small task it does. :]  And it always reports a git ID, even when the
> HEAD is tagged -- this is a bug.
> 
> This patch replaces it with a Bourne Shell script that uses git
> commands to do the same.  I can't come up with a scenario where someone
> would use a git repo and refuse to install git core at the same time,
> so I think it's reasonable to assume git is available.
> 
> The new script also reports uncommitted changes by adding -git_dirty to
> the version string.  Obviously you can't see from that _what_ has been
> changed from the last commit, so it's more of a reminder that you
> forgot to commit something.
> 
> The script is easily extensible: simply add a check for Mercurial (or
> whatever) below the git check.
> 
> Note: the script doesn't print a newline char anymore.  That's only
> because it was easier to implement it that way, not a feature (or bug).
> 'make kernelrelease' doesn't care.
> 
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Thanks Rene.
Applied with an:
Acked-by: Ryan Anderson <ryan@michonline.com>

	Sam
