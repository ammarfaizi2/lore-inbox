Return-Path: <linux-kernel-owner+w=401wt.eu-S1753836AbWLRLRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbWLRLRg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbWLRLRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:17:36 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51724 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbWLRLRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:17:35 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 06:09:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Steven Whitehouse <swhiteho@redhat.com>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org, Patrick Caulfield <pcaulfie@redhat.com>,
       Chris Zubrzycki <chris@middle--earth.org>, Adrian Bunk <bunk@stusta.de>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       Aleksandr Koltsoff <czr@iki.fi>
Subject: Re: [GFS2] Fix Kconfig [2/2]
In-Reply-To: <Pine.LNX.4.61.0612181149420.22591@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0612180606200.23454@localhost.localdomain>
References: <1166435650.3752.1263.camel@quoit.chygwyn.com>
 <1166435849.3752.1266.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0612181149420.22591@yvahk01.tjqt.qr>
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

On Mon, 18 Dec 2006, Jan Engelhardt wrote:

>
> On Dec 18 2006 09:57, Steven Whitehouse wrote:
> > config GFS2_FS_LOCKING_DLM
> > 	tristate "GFS2 DLM locking module"
> >-	depends on GFS2_FS
> >+	depends on GFS2_FS && NET && INET && (IPV6 || IPV6=n)
>
> What is this supposed to do? IPV6 || IPV6=n is a tautology AFAICS.

no, we just went through that and russell king is correct -- see the
brief series of posts from earlier this morning during which i made a
fool of myself.  :-P

although, it *is* curious that there appear to be only four places in
the entire source tree that incorporate that type of logical check.
i'm still trying to wrap my head around the rationale for that
particular combination, since it does seem to be rather infrequent and
(at least for me) a little non-intuitive.

rday
