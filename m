Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbRCEUkH>; Mon, 5 Mar 2001 15:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130418AbRCEUj6>; Mon, 5 Mar 2001 15:39:58 -0500
Received: from [199.239.160.155] ([199.239.160.155]:31873 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S130417AbRCEUjn>; Mon, 5 Mar 2001 15:39:43 -0500
Date: Mon, 5 Mar 2001 12:39:07 -0800
From: Robert Read <rread@datarithm.net>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Paul Flinders <P.Flinders@ftel.co.uk>, Jeff Mcadams <jeffm@iglou.com>,
        Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010305123907.C6400@tenchi.datarithm.net>
Mail-Followup-To: Pozsar Balazs <pozsy@sch.bme.hu>,
	Paul Flinders <P.Flinders@ftel.co.uk>,
	Jeff Mcadams <jeffm@iglou.com>,
	Rik van Riel <riel@conectiva.com.br>,
	John Kodis <kodis@mail630.gsfc.nasa.gov>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, bug-bash@gnu.org
In-Reply-To: <3AA3BC4E.FA794103@ftel.co.uk> <Pine.GSO.4.30.0103051954420.25495-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0103051954420.25495-100000@balu>; from pozsy@sch.bme.hu on Mon, Mar 05, 2001 at 07:58:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 07:58:52PM +0100, Pozsar Balazs wrote:
> 
> And what does POSIX say about "#!/bin/sh\r" ?
> In other words: should the kernel look for the interpreter between the !
> and the newline, or [the first space or newline] or the first whitespace?
> 
> IMHO, the first whitespace. Which means that "#!/bin/sh\r" should invoke
> /bin/sh. (though it is junk).
> 

The line terminator, '\n', is what terminates the interpreter.  White
space (in this case, only ' ' and '\t') is used to seperate the
arguments to the interpreter.  This allows scripts to pass args to
intepreters, as in #!/usr/bin/per -w or #!/usr/bin/env perl -w

So is '\r' a line terminator? For Linux, no.  Should '\r' seperate
arguments?  No, that would be very strange.

robert

