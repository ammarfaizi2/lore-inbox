Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130738AbRCEWf3>; Mon, 5 Mar 2001 17:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130739AbRCEWfT>; Mon, 5 Mar 2001 17:35:19 -0500
Received: from [199.239.160.155] ([199.239.160.155]:33921 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S130738AbRCEWfH>; Mon, 5 Mar 2001 17:35:07 -0500
Date: Mon, 5 Mar 2001 14:34:45 -0800
From: Robert Read <rread@datarithm.net>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Paul Flinders <P.Flinders@ftel.co.uk>, Jeff Mcadams <jeffm@iglou.com>,
        Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
Message-ID: <20010305143445.D6400@tenchi.datarithm.net>
Mail-Followup-To: Pozsar Balazs <pozsy@sch.bme.hu>,
	Paul Flinders <P.Flinders@ftel.co.uk>,
	Jeff Mcadams <jeffm@iglou.com>,
	Rik van Riel <riel@conectiva.com.br>,
	John Kodis <kodis@mail630.gsfc.nasa.gov>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010305123907.C6400@tenchi.datarithm.net> <Pine.GSO.4.30.0103052154360.28239-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0103052154360.28239-100000@balu>; from pozsy@sch.bme.hu on Mon, Mar 05, 2001 at 10:05:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 10:05:36PM +0100, Pozsar Balazs wrote:
> On Mon, 5 Mar 2001, Robert Read wrote:
> > On Mon, Mar 05, 2001 at 07:58:52PM +0100, Pozsar Balazs wrote:
> > >
> > > And what does POSIX say about "#!/bin/sh\r" ?
> > > In other words: should the kernel look for the interpreter between the !
> > > and the newline, or [the first space or newline] or the first whitespace?
> > >
> > > IMHO, the first whitespace. Which means that "#!/bin/sh\r" should invoke
> > > /bin/sh. (though it is junk).
> >
> > The line terminator, '\n', is what terminates the interpreter.  White
> > space (in this case, only ' ' and '\t') is used to seperate the
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > arguments to the interpreter.
> 
> 
> The last little tiny thing that bothers me: why? Why only ' ' and '\t' _in
> this case_? As someone mentioned, even isspace() returns whitespace.
> 
> A possible answer (that i can think of), is that those ar the whitespaces,
> which are in IFS (as said previously), taking out us from kernel-space
> into userspace. But imho we shouldn't define another set whitespace for
> this case, can't we just use what isspace() says?

And isspace('\n') is also true.  At question here is not the
definition of whitespace.  The question is, what is the definition of
a command line?  What characters are valid command line seperators?

robert
