Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRKBUEf>; Fri, 2 Nov 2001 15:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280816AbRKBUEZ>; Fri, 2 Nov 2001 15:04:25 -0500
Received: from dsl-65-185-37-21.telocity.com ([65.185.37.21]:38179 "EHLO
	onevista.com") by vger.kernel.org with ESMTP id <S280814AbRKBUEL>;
	Fri, 2 Nov 2001 15:04:11 -0500
Reply-To: johna@onevista.com
Content-Type: text/plain; charset=US-ASCII
From: John Adams <johna@onevista.com>
Organization: One Vista Associates
To: linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
Date: Fri, 2 Nov 2001 16:04:13 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX>
In-Reply-To: <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Message-Id: <01110215041301.01066@flash>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 18:51, Riley Williams wrote:
> Hi Doug.
>
> >> Are you sure?
> >>
> >>> find / -name "wanted-but-lost-download" | eat
> >>
> >> Doesn't work - you're piping the stdin there, not stderr as per my
> >> example above. AFAIK, there's no way to pipe stderr without also
> >> piping stdout, hence this sort of solution just doesn't work.
> >
> > The Bourne shell is more perverse than you realize:
> >
> > $ exec 3>&1; find / -name "wanted-but-lost-download" 2>&1 1>&3 3>&- |
> > eat
> >
> > [stolen from "Csh Programming Considered Harmful" by Tom Christiansen]
> >
> > Horrible, but does work.  ;)

You really do take the hard way.  Try this to pipe just stderr:
command_that_outputs_on_1_and_2   2>/dev/stdout 1>/dev/null | eat
