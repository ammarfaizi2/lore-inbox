Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTLLVk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTLLVk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:40:28 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52204
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262161AbTLLViU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:38:20 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Fri, 12 Dec 2003 15:37:42 -0600
User-Agent: KMail/1.5
Cc: Hua Zhong <hzhong@cisco.com>, "'Andy Isaacson'" <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <20031212135609.GE6112@wohnheim.fh-wedel.de> <20031212142459.GG6112@wohnheim.fh-wedel.de>
In-Reply-To: <20031212142459.GG6112@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312121537.42303.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 08:24, Jörn Engel wrote:

> > ...and it sucks.  Same problem as with updatedb - 99% of all work is
> > bogus, but you don't know which 99%, because the one knowing about it,
> > the kernel, doesn't tell you a thing.
>
> Actually, updatedb sucks even worse.  The database is notoriously
> outdated and each run of updatedb has the effect of flushing the
> cache.  Because of the cache-flushing effect, you cannot even run it
> with maximum niceness.  Running it still hurts you *afterwards*.
>
> Same goes for you userland daemon without kernel support.
>
> Jörn

1) The date optimization, only looking at files newer than the last run, means 
you can avoid looking at 90% of the filesystem.

2) If drop-behind ever gets working, life is good for this sort of thing.  If 
not, there's always O_DIRECT or its replacement (whatever Linus and the 
oracle guy were arguing about last month)...

Rob
