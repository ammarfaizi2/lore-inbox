Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbUCORGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUCORGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:06:12 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:12527 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262706AbUCORGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:06:03 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
Date: Mon, 15 Mar 2004 11:05:36 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <1078775149.23059.25.camel@luke> <04031207520900.07660@tabby> <1079103602.1571.26.camel@quaoar>
In-Reply-To: <1079103602.1571.26.camel@quaoar>
MIME-Version: 1.0
Message-Id: <04031511053600.13518@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2004 09:00, Søren Hansen wrote:
> fre, 2004-03-12 kl. 14:52 skrev Jesse Pollard:
> > > Let's just for a second assume that I'm the slow one here. Why is the
> > > world a less secure place after this system is incorporated into the
> > > kernel?
> >
> > Because a rogue client will have access to every uid on the server.
>
> As opposed to now when a rogue client is very well contained?
>
> > Mapping provides a shield to protect the server.
>
> A mapping system could provide extra security if implemented on the
> server. That's true. This is, however, not what I'm trying to do. This
> system is NOT a security related one (it doesn't increase nor decrease
> security), but rather a convenience related one.

Then it becomes an identity mapping (as in 1:1) and is therefore
not usefull.

If you are doing double mapping, then I (as a server administrator)
would not export the filesystem to you.

The current situation is always a 1:1 mapping (NFS version < 4). Therefore
any filesystem export is by definition within the same security domain.

If you as an administrator of a client host violate the UIDs assigned to
you (by hiding the audit trail), then you are violating the rules established
in that security domain; and should not be trusted - and the client host
should not have an available export.

It is never necessary to map on a client. It means that the server has been
improperly setup, or that the client is not within the proper security domain.
