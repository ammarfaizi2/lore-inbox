Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263329AbRFWXdq>; Sat, 23 Jun 2001 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbRFWXdi>; Sat, 23 Jun 2001 19:33:38 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:50835 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263334AbRFWXdY>; Sat, 23 Jun 2001 19:33:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: Maintainers master list?
Date: Sat, 23 Jun 2001 13:39:27 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010622160002.B16285@thyrsus.com> <Pine.LNX.4.33L.0106221753140.4442-100000@duckman.distro.conectiva> <Ag1ABB.A.1QG._Z7M7@dinero.interactivesi.com>
In-Reply-To: <Ag1ABB.A.1QG._Z7M7@dinero.interactivesi.com>
MIME-Version: 1.0
Message-Id: <01062313392708.00696@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 June 2001 17:19, Timur Tabi wrote:
> ** Reply to message from "Eric S. Raymond" <esr@thyrsus.com> on Fri, 22 Jun
> 2001 17:09:45 -0400
>
> > What happens now when somebody takes over responsibility for a file
> > or subsystem and the MAINTAINERS file doesn't get patched, either because
> > that person forgets to send a MAINTAINERS update or Linus doesn't
> > happen to take the MAINTAINERS patch for a while?
>
> Wouldn't this whole problem go away if the kernel source were stored in a
> master CVS repository?  Maintainers would have write access to their
> respective code, but only Linus and Alan would have delete access. 
> Everyone else would have read-only access.

This has been suggested about eight thousand times so far, and the answer is 
"no".  I'm fairly certain there's a FAQ entry on this.

The reason Linus won't do it is it conflicts with the way he works.  He 
approves patches by reading through them in his mail reader (Pine, I think) 
and appending the ones he likes to a file.  Then when he's done reading mail 
he pipes the whole file to patch and it goes into his tree.

(I'm pondering an idea of sending Linus a perl script that he can use to pipe 
that file to patch which will split out the individual emails and forward 
them to an otherwise read-only "patches-linus-has-applied" mailing list.  The 
important part of this idea is it doesn't change the way he works or make him 
do any extra work at all.  And we get the documentation in the emails and a 
record of what patches got applied when.  And this WOULD allow a fairly 
granular CVS tree to be kept up-to-date by a third party who simply 
subscribes to the list and automatically feeds the patches into CVS.)

But Linus will NOT allow a line of code into his tree which he hasn't 
personally approved.  He may apply patches forwarded to him by maintainers 
without thoroughly reading them first, but he still approves them and knows 
when they go in, and makes sure they don't conflict with anything else he's 
applying or already applied.  So in a "Linux-kernel CVS tree", only Linus 
would have the ability to check stuff in, so he considers it a waste of time 
and just sends us tarballs instead.

The fact Linus does this is a bottleneck, sure.  But the fact we've got one 
guy in charge making decisions and vetoing anything that shouldn't go in is 
also the main reason we've got a coherent source base.  Look at the ongoing 
fight between Rik and Andrea: even smart people who are generally right can 
disagree about architectural direction, and if they both make changes without 
somebody steering Bad Things will result.

Rob

