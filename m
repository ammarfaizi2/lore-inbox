Return-Path: <linux-kernel-owner+w=401wt.eu-S964852AbWLOUw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWLOUw2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWLOUw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:52:28 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:43717 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964852AbWLOUw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:52:27 -0500
X-Originating-Ip: 24.148.236.183
Date: Fri, 15 Dec 2006 15:48:09 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
 <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
 <4581DAB0.2060505@s5r6.in-berlin.de> <Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006, Jan Engelhardt wrote:

>
> >>> Indeed, there seems to be lots of potential clean-up there.
> >>> Including duplicate macros like:
> >>>
> >>> ./drivers/ide/ide-cd.h:#define ARY_LEN(a) ((sizeof(a) / sizeof(a[0])))
> >>
> >> not surprisingly, i have a script "arraysize.sh":
> >...
> >
> >This could also come in the flavor "sizeof(a) / sizeof(*a)".
> >I haven't checked if there are actual instances.
>
> Even  sizeof a / sizeof *a
>
> may happen.

yes, sadly, there are a number of those as well.  back to the drawing
board.

rday

p.s.  you know, once i nail this script, somebody better apply the end
result.  :-)
