Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbUJ1Rtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUJ1Rtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUJ1Rtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:49:42 -0400
Received: from mail.skule.net ([216.235.14.165]:36030 "EHLO mail.skule.net")
	by vger.kernel.org with ESMTP id S263015AbUJ1RtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:49:06 -0400
Date: Thu, 28 Oct 2004 13:48:38 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits - "@" question
Message-ID: <20041028174838.GA794@mjfrazer.org>
References: <200410230426.i9N4Qd9k004757@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <200410230426.i9N4Qd9k004757@work.bitmover.com>
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry: They're great! They're like sex except I'm having them.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Larry McVoy <lm@bitmover.com> [04/10/23 01:31]:
> The web pages on bkbits.net contain email addresses.  This is probably
> about a 4 year too late question but would it help reduce spam if we
> did something like  s/@/ (at) / for all those addresses?

Hi Larry:  I've used this for a while to add email addresses to my web
pages and I get almost no spam any more, < 10 per month!

[mjfrazer@pacific depictII]$ html-encode mark@mjfrazer.rog
&#109;&#97;&#114;&#107;&#64;&#109;&#106;&#102;&#114;&#97;&#122;&#101;&#114;&#46;&#114;&#111;&#103;
[mjfrazer@pacific depictII]$ 

I've attached the source.

> What are all of you doing to filter spam?

I use bogofilter, but only get about 10 per month anyways.

cheers
-mark
-- 
People said I was dumb but I proved them! - Fry

--UugvWAfsgieZRqgk
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="html-encode.c"

#include <stdio.h>
#include <unistd.h>

int usage (char *err) {
	if (err) printf ("%s\n", err);
	printf ("Usage: html-encode [-v] <string> <string> <string>\n");
	return 1;
}

int main (int argc, char **argv)
{
	int i, j, verbose = 0;

	while ((i = getopt (argc, argv, "v")) > -1) {
		switch (i) {
			case 'v': verbose = 1; break;
			default: return usage (0);
		}
	}
	if (argc - optind < 1)
		usage ("Nothing to do");

	for (i = optind; i < argc; i++) {
		if (verbose) printf ("%s: ", argv[i]);
		for (j = 0; j < strlen (argv[i]); j++) {
			printf ("&#%d;", argv[i][j]);
		}
		printf ("\n");
	}

	return 0;
}

--UugvWAfsgieZRqgk--
