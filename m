Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTBAMCw>; Sat, 1 Feb 2003 07:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTBAMCw>; Sat, 1 Feb 2003 07:02:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:64530 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264815AbTBAMCv>;
	Sat, 1 Feb 2003 07:02:51 -0500
Date: Sat, 1 Feb 2003 13:12:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, "J.A. Magallon" <jamagallon@able.es>,
       linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
Message-ID: <20030201121213.GA923@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	"J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <20030131222257.GA11011@mars.ravnborg.org> <3E3B0557.3070400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E3B0557.3070400@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 06:23:03PM -0500, Jeff Garzik wrote:
> 
> klibc uses perl for text munging.  i.e. one of Perl's acknowledged 
> strengths.  This is not a case of choosing a favorite script language, 
> but instead a case of choosing "the right tool for the job."

Choosing the right tool for the right job is an argument that matters
in this context.
Two major type of arguments pop's up when selecting diverse tools:
1) "the right tool for the right job"
2) "the most preferred tool"

My main objective is that argument 2) should _not_ be the rationale
behind adding a new tool to the mandatory tool chain.

> Therefore, any rewrite of _this_ _particular_ script in C or shell 
> script would be willfully choosing a sub-optimal implementation language 
> for this task.
The perl scripts used in klibc looks straightforward, expect one that uses
some md5 CPAN module.
Like with C you can in perl pull in a lot of uncommon stuff.

My main objective is to avoid a lot of noise due to one added tool
that may not be required.
Part of the noise will be because people do not understand the
syntax.

> If you take into account the fact that the overwhelming 
> majority of the target audience does indeed have Perl on their system, 
> then that only serves to make it more clear that any such perl-to-C 
> rewrite would not be on any technical nor practical basis at all.

One example could be fixdep:
fixdep could have been done in perl as well. Implementing that one
in c does not count as an "perl-to-C" translation.
To repeat my point.

There is only one good reason to add additional tools to the mandatory
set in the tool-chain. At that reason is that the tool is the right
choice, and not just someones favourite.
If that imply a small C utility then fine.

> Thanks for raising this subject!  I wanted to give your answer some 
> consideration, because it is worth mentioning, and discussing.

Thanks self. I just want to make sure the technically right choice is taken.

	Sam
