Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUDHOJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUDHOJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:09:34 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:41198 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261772AbUDHOJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:09:23 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Dhruv Gami <gami@d10systems.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: setgid - its current use
Date: Thu, 8 Apr 2004 09:08:28 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0404072140070.14350@d10systems.homelinux.com> <200404081041.25006.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0404072304500.14350@d10systems.homelinux.com>
In-Reply-To: <Pine.LNX.4.58.0404072304500.14350@d10systems.homelinux.com>
MIME-Version: 1.0
Message-Id: <04040809082800.04599@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 April 2004 22:06, Dhruv Gami wrote:
> On Thu, 8 Apr 2004, Denis Vlasenko wrote:
> > On Thursday 08 April 2004 04:46, Dhruv Gami wrote:
> > > I'd like to know the possibility of using setgid for users to switch
> > > their groups and work as a member of a particular group. Essentially,
> > > if i want one user, who belongs to groups X, Y and Z to create a file
> > > as a member of group Y while he's logged on as a member of group X,
> > > would it be possible through setgid() ?
> >
> > it is possible through chmod
>
> but that would be an explicit way of doing it, right ? I'm looking for
> doing this via some system calls or something transparent to the user. At
> most I'd like to query the user for the group as which he wants to work.
> Which would essentially be a question I ask at login or beginning of a
> session.

You want the "newgrp" utility.

>From the manpage:

       Newgrp  changes  the group identification of its caller, analogously to
       login(1).  The same person remains logged in, and the current directory
       is  unchanged, but calculations of access permissions to files are per-
       formed with respect to the new group ID.

       If no group is specified, the GID is changed to the login GID.
