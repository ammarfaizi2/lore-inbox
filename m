Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282064AbRLFTag>; Thu, 6 Dec 2001 14:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282523AbRLFTa0>; Thu, 6 Dec 2001 14:30:26 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19603 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282064AbRLFTaL>; Thu, 6 Dec 2001 14:30:11 -0500
Date: Thu, 6 Dec 2001 12:34:48 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
        rusty@rustcorp.com.au, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik vav Riel <riel@conectiva.com.br>, lars.spam@nocrew.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        lkml <linux-kernel@vger.kernel.org>, jmerkey@timpanogas.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206123448.B23263@vger.timpanogas.org>
In-Reply-To: <20011206112731.C22534@vger.timpanogas.org> <Pine.LNX.4.40.0112061046110.1603-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112061046110.1603-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Thu, Dec 06, 2001 at 11:11:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 11:11:27AM -0800, Davide Libenzi wrote:
> On Thu, 6 Dec 2001, Jeff V. Merkey wrote:
> 
> > Guys,
> >
> > I am the maintaner of SCI, the ccNUMA technology standard.  I know
> > alot about this stuff, and have been involved with SCI since
> > 1994.  I work with it every day and the Dolphin guys on some huge
> > supercomputer accounts, like Los Alamos and Sandia Labs in NM.
> > I will tell you this from what I know.
> >
> > A shared everything approach is a programmers dream come true,
> > but you can forget getting reasonable fault tolerance with it.  The
> > shared memory zealots want everyone to believe ccNUMA is better
> > than sex, but it does not scale when compared to Shared-Nothing
> > programming models.  There's also a lot of tough issues for dealing
> > with failed nodes, and how you recover when peoples memory is
> > all over the place across a nuch of machines.
> 
> If you can afford rewriting/rearchitecting your application it's pretty
> clear that the share-nothing model is the winner one.
> But if you can rewrite your application using a share-nothing model you
> don't need any fancy clustering architectures since beowulf like cluster
> would work for you and they'll give you a great scalability over the
> number of nodes.
> The problem arises when you've to choose between a new architecture
> ( share nothing ) using conventional clusters and a
> share-all/keep-all-your-application-as-is one.
> The share nothing is cheap and gives you a very nice scalability, these
> are the two mayor pros for this solution.
> On the other side you've a vary bad scalability and a very expensive
> solution.
> But you've to consider :
> 
> 1) rewriting is risky
> 
> 2) good developers to rewrite your stuff are expensive ( $100K up to $150K
> 	in my area )
> 
> These are the reason that let me think that conventional SMP machines will
> have a future in addition to my believing that technology will help a lot
> to improve scalability.
> 

There's a way through the fog.  Shared Nothing with explicit coherence.
You are correct, applications need to be rewritten to exploit it.  It 
is possible to run existing SMP apps process -> process across nodes
with ccNUMA, and this works, but you don't get the scaling as shared
nothing.

Jeff

Jeff


> 
> 
> 
> - Davide
> 
> 
> 
