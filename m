Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277021AbRJHRhu>; Mon, 8 Oct 2001 13:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277016AbRJHRhb>; Mon, 8 Oct 2001 13:37:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37870 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S277021AbRJHRhY>; Mon, 8 Oct 2001 13:37:24 -0400
Message-ID: <3BC1E294.1A4FB12D@mvista.com>
Date: Mon, 08 Oct 2001 10:29:56 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au> <3BC1735F.41CBF5C1@intracom.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pantelis Antoniou wrote:
> 
> Hi there.
> 
> If anyone is interested I have already made a perl
> script that produces assembler offsets from structure
> members.
> 
> It doesn't need to run native since it reads the
> header files, extract the structures and by using
> objdump calculates the offsets automatically.
> 
> Maybe it needs some more work for what you describe,
> but it's exactly what you describe.
> 
> If you're interested please email me directly for
> more information.
> 
One of the problems with this sort of thing is that it has a hard time
getting the CPP macros right.  The best way to do this sort of thing is
to actually compile the header file with all the CONFIG defines and a
set of tools (read macros) that produce the required offsets.  This way
you get what you want and don't have to reinvent the CPP stuff.  It also
allows production of #define constants and other constructs that folks
push into CPP, in a very simple and straight forward manner.

Been there, done that.

George
