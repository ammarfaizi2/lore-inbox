Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUCLN7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCLN7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:59:01 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:61941 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262117AbUCLN65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:58:57 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: UID/GID mapping system
Date: Fri, 12 Mar 2004 07:58:33 -0600
X-Mailer: KMail [version 1.2]
Cc: "Andreas Dilger <=?CP 1252?q?adilger=40clusterfs=2Ecom?=> =?CP
	1252?q?=2CS=F8ren=20Hansen?=" <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04031108083100.05054@tabby> <20040311160245.GB18466@fieldses.org>
In-Reply-To: <20040311160245.GB18466@fieldses.org>
MIME-Version: 1.0
Message-Id: <04031207583301.07660@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 10:02, J. Bruce Fields wrote:
> On Thu, Mar 11, 2004 at 08:08:31AM -0600, Jesse Pollard wrote:
> > On Wednesday 10 March 2004 17:46, Andreas Dilger wrote:
> > > If the client is trusted to mount NFS, then it is also trusted enough
> > > not to use the wrong UID.  There is no "more" or "less" safe in this
> > > regard.
> >
> > It is only trusted to not misuse the uids that are mapped for that
> > client. If the client DOES misuse the uids, then only those mapped uids
> > will be affected. UIDS that are not mapped for that host will be
> > protected.
> >
> > It is to ISOLATE the penetration to the host that this is done. The
> > server will not and should not extend trust to any uid not authorized to
> > that host. This is what the UID/GID maps on the server provide.
>
> You're making an argument that uid mapping on the server could be used
> to provide additional security; I agree.
>
> I don't believe you can argue, however, that providing uid mapping on
> the client would *decrease* security, unless you believe that mapping
> uid's on the client precludes also mapping uid's on the server.

Not really - it would be a 1:1 map... so what would be the purpose?

The problem is in the audit - the server would report a violation in
uid xxx. Which according to it's records is not used on the penetrated client
(at least not via the filesystem). Yet the administrator would report that the
uid is valid (because of a bogus local map).

Double mapping also doubles the audit complications :-)
