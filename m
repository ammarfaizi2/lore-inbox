Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267944AbTBMAxr>; Wed, 12 Feb 2003 19:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267945AbTBMAxr>; Wed, 12 Feb 2003 19:53:47 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:64778 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267944AbTBMAxp>; Wed, 12 Feb 2003 19:53:45 -0500
Date: Thu, 13 Feb 2003 12:02:31 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "'Christoph Hellwig'" <hch@infradead.org>
cc: Crispin Cowan <crispin@wirex.com>, <torvalds@transmeta.com>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, <greg@kroah.com>,
       "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>,
       <linux-security-module@wirex.com>, magniett <Frederic.Magniette@lri.fr>,
       <linux-kernel@vger.kernel.org>
Subject: Re: What went wrong with LSM, was: Re: [BK PATCH] LSM changes for
 2.5.59
In-Reply-To: <20030212230550.A19831@infradead.org>
Message-ID: <Pine.LNX.4.44.0302131014010.2621-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, 'Christoph Hellwig' wrote:

> And here we see _the_ problem with the LSM process.  LSM wasn't
> developed as part of the broad kernel community (lkml) but on
> a rather small, almost private list.

Many of the things that you are saying in this discussion are untrue.

The bulk of the development process was carried out for more than two
years on the LSM development mailing list, which is fully public and open
to anyone.  It is not "almost private", whatever that is supposed to mean.

Should those thousands of emails have ended up on lkml instead?  Before
you answer, try reading the first thousand (which I actually did when 
joining the project).

As for "rather small", hundreds of people were involved in discussion
during the initial development phase (Chris Wright generated some stats on
this last year).  These people included numerous long time kernel
developers, commercial developers, well known security researchers and 
anyone else who was interested enough to join.

There were specific LSM discussions at two kernel summits, while multiple
OLS presentations have been given on LSM.  These events were further
covered by numerous online media sites.  LSM information was posted
several times to lkml, before and after the initial codebase was
developed.  If you didn't notice any of these things before you started
complaining recently, please don't blame the LSM developers.

I do agree that we should have worked more closely with maintainers from
the beginning, but this was not out of trying to be secretive (of which we
have been accused quite a few times).  This happened out of believing that
we should reach a design consensus and write some code via the before
bothering any maintainers.  This approach was clearly flawed, and efforts
have since been made to rectify this for ongoing development.

(Note that this process occured publicly on the LSM development mailing
list, and that code was checked in as it was developed to publicly 
accessible bk repositories).

And I also agree that it would have been better if more people in general
discussed LSM on lkml.  For whatever reason, they did not.  I can point
you to many instances of LSM posts being made to lkml with zero response.  

The first LSM patch sent to lkml was actually applied by Linus with no
discussion from anyone else, _very_ much to our surprise.  We definitely
expected significant discussion from lkml subscribers and a highly
probable subsequent phase of rework before it would be accepted into
mainline.


> People added hooks not because they generally make sense but because
> their module needed it.

SELinux was used as a model for LSM because SELinux is _itself_ a
generalized access control framework (arising from over a decade of
research).  SELinux already supported MAC, TE, RBAC, IBAC and MLS, and was
one of the few existing Linux security projects with significant coverage
across the kernel.  Thus, it was an ideal basis for use as a model for the
initial design of the LSM hook placement and abstraction strategy.  Many
other projects were used as models as well.  In fact, I reviewed in detail
_every_ single Linux security project I could find when implementing the
networking hooks.

Claims of a "secret" and non-generalized design process are baseless.


- James
-- 
James Morris
<jmorris@intercode.com.au>




