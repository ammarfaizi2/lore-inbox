Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129389AbRCEQTN>; Mon, 5 Mar 2001 11:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRCEQTE>; Mon, 5 Mar 2001 11:19:04 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:64152 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S129389AbRCEQSw>; Mon, 5 Mar 2001 11:18:52 -0500
Message-ID: <3AA3BC4E.FA794103@ftel.co.uk>
Date: Mon, 05 Mar 2001 16:18:22 +0000
From: Paul Flinders <P.Flinders@ftel.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Mcadams <jeffm@iglou.com>
CC: Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov> <Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva> <20010305105943.A25964@iglou.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mcadams wrote:

> Also sprach Rik van Riel
> >On Mon, 5 Mar 2001, John Kodis wrote:
> >> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> >> > Somebody must have missed the boat entirely. Unix does not, never
> >> > has, and never will end a text line with '\r'.
>
> >> Unix does not, never has, and never will end a text line with ' ' (a
> >> space character) or with \t (a tab character).  Yet if I begin a
> >> shell script with '#!/bin/sh ' or '#!/bin/sh\t', the training white
> >> space is striped and /bin/sh gets exec'd.  Since \r has no special
> >> significance to Unix, I'd expect it to be treated the same as any
> >> other whitespace character -- it should be striped, and /bin/sh
> >> should get exec'd.
>
> >Makes sense, IMHO...
>
> That only makes sense if:
> #!/bin/shasdf\n
> would also exec /bin/sh.

POSIX disagrees with you (accd to the manual page)

$ man isspace
       ....
       isspace()
              checks for white-space characters.  In the "C"  and
              "POSIX"   locales,   these  are:  space,  form-feed
              ('\f'), newline  ('\n'),  carriage  return  ('\r'),
              horizontal tab ('\t'), and vertical tab ('\v').


