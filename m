Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRCFPGt>; Tue, 6 Mar 2001 10:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130965AbRCFPGi>; Tue, 6 Mar 2001 10:06:38 -0500
Received: from cx866070-a.tucson1.az.home.com ([24.177.155.28]:15094 "EHLO
	aahz.klah.net") by vger.kernel.org with ESMTP id <S130882AbRCFPG1>;
	Tue, 6 Mar 2001 10:06:27 -0500
Date: Tue, 6 Mar 2001 08:14:57 -0700 (MST)
From: Jeff Coy <jcoy@klah.net>
Reply-To: jcoy@klah.net
To: Robert Read <rread@datarithm.net>
cc: Pozsar Balazs <pozsy@sch.bme.hu>, Paul Flinders <P.Flinders@ftel.co.uk>,
        Jeff Mcadams <jeffm@iglou.com>, Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305143445.D6400@tenchi.datarithm.net>
Message-ID: <Pine.LNX.4.10.10103060759480.27289-100000@aahz.klah.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Robert Read wrote:

> And isspace('\n') is also true.  At question here is not the
> definition of whitespace.  The question is, what is the definition of
> a command line?  What characters are valid command line seperators?
> 

It doesn't seem likely that '\r' is going to be accepted into the general
kernel.  I personally don't think the issue affects enough *nix systems
for this to be a big issue.

I used to work at an ISP where I maintained a Slowaris box with about 600
websites on it; this issue came up frequently with customers uploading
scripts in binary mode trying to run #!/usr/bin/perl^M.  The solution for
me was to just do the following:

	cd /usr/bin
	sudo ln -s perl^V^M perl

and it effectively solved the issue.  I havn't looked at slowaris 8, but
slowaris 7 still refuses to run #!/usr/bin/perl^M.  Why not just use a
simple one-time solution that will solve the problem & is portable to
other OS's?

Jeff
--
Resisting temptation is easier when you think you'll probably get
another chance later on.

