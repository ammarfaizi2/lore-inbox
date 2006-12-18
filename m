Return-Path: <linux-kernel-owner+w=401wt.eu-S1753823AbWLRLIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbWLRLIp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbWLRLIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:08:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbWLRLIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:08:44 -0500
Subject: Re: [GFS2] Fix Kconfig [2/2]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Chris Zubrzycki <chris@middle--earth.org>, Adrian Bunk <bunk@stusta.de>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       Aleksandr Koltsoff <czr@iki.fi>
In-Reply-To: <Pine.LNX.4.61.0612181149420.22591@yvahk01.tjqt.qr>
References: <1166435650.3752.1263.camel@quoit.chygwyn.com>
	 <1166435849.3752.1266.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0612181149420.22591@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 18 Dec 2006 11:10:40 +0000
Message-Id: <1166440240.3752.1276.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-12-18 at 11:50 +0100, Jan Engelhardt wrote:
> On Dec 18 2006 09:57, Steven Whitehouse wrote:
> > config GFS2_FS_LOCKING_DLM
> > 	tristate "GFS2 DLM locking module"
> >-	depends on GFS2_FS
> >+	depends on GFS2_FS && NET && INET && (IPV6 || IPV6=n)
> 
> What is this supposed to do? IPV6 || IPV6=n is a tautology AFAICS.
> 
> 
> 	-`J'

It looks odd, I'll grant you, but see the thread entitled "Re: [PATCH]
Remove logically superfluous comparisons from Kconfig files." and the
answer that Russell King has just given on the same subject where he
says:

>config FOO
>        tristate 'foo'
>        depends on BAR || BAR=n
>
>is not superfluous.  The allowed states for FOO with the above
>construct are (assuming modules are enabled):
>
>        BAR     FOO
>        Y       Y,M,N
>        M       M,N
>        N       Y,M,N

which hopefully explains it a bit better,

Steve.


