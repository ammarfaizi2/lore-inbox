Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131002AbRCFREl>; Tue, 6 Mar 2001 12:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131027AbRCFREd>; Tue, 6 Mar 2001 12:04:33 -0500
Received: from nas11-81.wms.club-internet.fr ([213.44.38.81]:21754 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S131002AbRCFREP>;
	Tue, 6 Mar 2001 12:04:15 -0500
Message-Id: <200103061659.RAA18212@microsoft.com>
Subject: Re: binfmt_script and ^M
From: Xavier Bestel <xavier.bestel@free.fr>
To: Sean Hunter <sean@dev.sportingbet.com>
Cc: Laramie Leavitt <laramie.leavitt@btinternet.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010306151242.D31649@dev.sportingbet.com>
In-Reply-To: <3AA4D92D.CDDB764D@ftel.co.uk>
	<JKEGJJAJPOLNIFPAEDHLEEDGCJAA.laramie.leavitt@btinternet.com> 
	<20010306151242.D31649@dev.sportingbet.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.8/+cvs.2001.02.16.08.55 - Preview Release)
Date: 06 Mar 2001 17:59:39 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't it be easier to run the script interpreter through WINE ? This
way we could workaround several Win32 peculiarities, and users wouldn't
bother taking special steps when coding on their home PC.

Xav

Le 06 Mar 2001 15:12:42 +0000, Sean Hunter a écrit :
> 
> I propose
> /proc/sys/kernel/im_too_lame_to_learn_how_to_use_the_most_basic_of_unix_tools_so_i_want_the_kernel_to_be_filled_with_crap_to_disguise_my_ineptitude
> 
> Any support?
> 
> Sean
> 
> On Tue, Mar 06, 2001 at 02:45:51PM -0000, Laramie Leavitt wrote:
> > > Andreas Schwab wrote:
> > > > Paul Flinders <paul@dawa.demon.co.uk> writes:
> > > > |> Andreas Schwab wrote:
> > > > |>
> > > > |> > This [isspace('\r') == 1] has no significance here.  The
> > > right thing to
> > > > |>
> > > > |> > look at is $IFS, which does not contain \r by default.
> > > The shell only splits
> > > > |>
> > > > |> > words by "IFS whitespace", and the kernel should be
> > > consistent with it:
> > > > |> >
> > > > |> > $ echo -e 'ls foo\r' | sh
> > > > |> > ls: foo: No such file or directory
> > > > |>
> > > > |> The problem with that argument is that #!<interpreter> can be applied
> > > > |> to more than just shells which understand $IFS, so which environment
> > > > |> variable does the kernel pick?
> > > >
> > > > The kernel should use the same default value of IFS as the Bourne shell,
> > > > ie. the same value you'll get with /bin/sh -c 'echo "$IFS"'.  This is
> > > > independent of any settings in the environment.
> > > >
> > > > |> It's a difficult one - logically white space should
> > > terminate the interpreter
> > > >
> > > > No, IFS-whitespace delimits arguments in the Bourne shell.
> > >
> > > Way back whenever processing #! was moved from the
> > > shell to the kernel** this argument would have made sense -
> > > today I'm not so sure.
> > >
> > > But I'm quite happy for the kernel to use just space and
> > > tab if it wishes, or anything else for that matter but it _is_
> > > confusing that the error code doesn't distinguish problems
> > > with the script from problems with the interpreter.
> > >
> > > **Did linux ever rely on the shell for this?
> > 
> > Maybe the correct answer would be to create a proc entry for this.
> > That allow the user to decide what is whitespace on his machine,
> > since nobody here appears to agree.
> > 
> > User:  hmm... Wonder what happes if i do the following
> >        %cat '$#! \n\t\r' > /proc/whitespace
> > later, % config.sh : Error file not found.
> > Oops, bug report... ;-)
> > 
> > Laramie
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

