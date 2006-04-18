Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWDRSls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWDRSls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWDRSls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:41:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34791 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932086AbWDRSlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:41:47 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 19:46:49 +0100
Message-Id: <1145386009.21723.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 09:50 -0700, Gerrit Huizenga wrote:
> > [1] http://www.ranum.com/security/computer_security/editorials/dumb/
> 
> Interesting but I'm not impressed by the article.  I think Stephen's

Its really a quick summary of ideas, and you need to read other stuff
beyond it to treat it as more than a "wakey wakey" piece. I'd also
suggest reading Ross Andersons work on the economics of computer
security if you haven't already.

> machine, these two approaches start to converge.  In the end it always
> comes down to "how much security are you prepared to endure, given
> that security almost always limits user capability".

You need to define "you" in the above to start with. Thats very
important in the sense that SELinux is capable of protecting systems
from their users to an extent (users are remarkably resourceful little
critters). The big goal in the Fedora case is that users don't notice
the security. 

> or are there places where a "less than perfect, easy to use, good enough"
> security policy?  I believe there is room for both based on the end
> users' needs and desires.  But that is just my opinion.

Poor security systems lead to less security than no security because it
lulls people into a false sense of security. Someone who knows their
house is insecure doesn't keep valuable items in it. Someone who thinks
their house is secure but it is not increases the risk not decreases it.

Doing good security is hard, and it does need to be from a "default
deny" basis. Ask anyone at IBM who remembers the default PATH starting
"." in AIX. Removing that was a move from default allow to default deny.
Nobody today would consider it anything but sane. Ditto the default
firewall on most Linux distros is 'default deny', something I did from
day one with Lokkit.

A security system that merely looks good is as useful as a database that
looks pretty but doesn't always store the data you asked it to, and
probably more dangerous.

Alan

