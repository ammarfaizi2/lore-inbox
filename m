Return-Path: <linux-kernel-owner+w=401wt.eu-S1750774AbXAPSfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXAPSfP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXAPSfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:35:14 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:49642 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbXAPSfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:35:13 -0500
X-Originating-Ip: 74.109.98.130
Date: Tue, 16 Jan 2007 13:23:32 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: "Ahmed S. Darwish" <darwish.07@gmail.com>, isely@pobox.com,
       video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
In-Reply-To: <20070116101633.39e57884.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0701161317530.21544@CPE00045a9c397f-CM001225dbafb6>
References: <20070116080136.GA30133@Ahmed>
 <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
 <20070116101633.39e57884.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Randy Dunlap wrote:

> On Tue, 16 Jan 2007 03:36:16 -0500 (EST) Robert P. J. Day wrote:
>
> > On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:
> >
> > > Use ARRAY_SIZE macro in pvrusb2-hdw.c file
> > >
> > > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> >
> > ... snip ...
> >
> > i'm not sure it's worth submitting multiple patches to convert
> > code expressions to the ARRAY_SIZE() macro since i was going to
> > wait for the next kernel release, and do that in one fell swoop
> > with a single patch.
> >
> > but if people higher up the food chain think it's a better idea to
> > do it a little at a time, that's fine.
>
> I'm not strictly on the food chain, but these 4 patches to pvrusb2
> should have been sent as one patch IMO.

  it's not like i'm trying to be territorial or anything.  if someone
wants to handle all these changes, go wild.  it's just that this
discussion of ARRAY_SIZE started back in december:

  http://lkml.org/lkml/2006/12/17/85

  i have a check for possibilities where this change can be done in my
"style" script:

  $ grep -Er "sizeof ?\(?([^\)]+)\)? ?/ ?sizeof ?\(?.*\1.*" .

  and i also have a script that crawls the tree, making the more
obvious changes.  (it will miss spots where the expression is broken
over two lines, stuff like that, so there will probably be a few
stragglers that will have to be done manually.)

  i haven't done anything with this lately as i was waiting for the
new release, whereupon i'm assuming the floodgates will be opened
and all the pending changes will finally start to wander upstream.
then all these changes might make sense as a multi-part patch.

  but, as i said, i'll leave this to people much smarter than me.

rday

