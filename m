Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264357AbUFINF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbUFINF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUFINF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:05:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:50326 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264357AbUFINFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:05:54 -0400
Date: Wed, 9 Jun 2004 15:05:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, nathans@sgi.com, owner-xfs@oss.sgi.com
Subject: Re: [STACK] >3k call path in xfs
Message-ID: <20040609130529.GL21168@wohnheim.fh-wedel.de>
References: <20040609122647.GF21168@wohnheim.fh-wedel.de> <200406091454.21182.linux-kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200406091454.21182.linux-kernel@borntraeger.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 14:54:17 +0200, Christian Borntraeger wrote:
> Jörn Engel wrote:
> > 3k is not really bad yet, I just like to keep 1k of headroom for
> > surprises like an extra int foo[256] in a structure.
> > stackframes for call path too long (3064):
> [...]
> >       12  panic
> [...]
> 
> I agree thats good to reduce stack size. 
> 
> On the other hand I think call traces containing panic are not a call trace 
> I want to see at all.

Does panic switch to a different stack?  If that was the case, you'd
be right and I'd have to make some adjustments.

Or do you mean that at the time of panic, a stack overflow simply
doesn't matter anymore.  The only data that may get corrupted is the
dump for a developer to analyse, after all.  (I'd like to make such a
claim someday, just to hear RAS people scream bloody murder. ;))

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
