Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbTAOQYP>; Wed, 15 Jan 2003 11:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbTAOQYP>; Wed, 15 Jan 2003 11:24:15 -0500
Received: from [66.70.28.20] ([66.70.28.20]:28165 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266665AbTAOQYJ>; Wed, 15 Jan 2003 11:24:09 -0500
Date: Wed, 15 Jan 2003 17:22:19 +0100
From: DervishD <raul@pleyades.net>
To: Jakob Oestergaard <jakob@unthought.net>, jw schultz <jw@pegasys.ws>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115162219.GB86@DervishD>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc> <20030115082527.GA22689@pegasys.ws> <20030115114130.GD66@DervishD> <20030115131617.GA8621@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030115131617.GA8621@unthought.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jakob :)

> >     Really, I'm thinking seriously about not rewritting argv[0] at
> > all. The problem is that may confuse the user when issuing 'ps' or
> > looking at /proc :((
> What about
[...]

    Mmm, interesting idea. A simpler solution is just copy the needed
argv0. In your example, about 500 bytes are wasted ;))) By using the
needed size at argv0, we have the space needed.

    If execv doesn't do any magic with the supplied argv array, then
this should work.

> For the same effect without the --very-magic argument, you could simply
> do an "if (argc != 2 || strlen(argv[0]) != 511)" instead.

    No, because the len of argv[0] being 'my proggy' is 9, that is not
511 ;)) We cannot tell the allocated space, I'm afraid O:)
 
> Am I smoking crack, or could the above work?

    I should smoke crack, definitely. That way I would not mess with
that argv thing XDDDD

    Thanks :)
    Raúl
