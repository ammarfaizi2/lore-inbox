Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSGXIj1>; Wed, 24 Jul 2002 04:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSGXIj1>; Wed, 24 Jul 2002 04:39:27 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:11477 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318282AbSGXIj0>;
	Wed, 24 Jul 2002 04:39:26 -0400
Date: Wed, 24 Jul 2002 14:49:37 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@suse.de>
Cc: bcrl@redhat.com, dalecki@evision.ag, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27 enum
Message-Id: <20020724144937.3aa70f29.rusty@rustcorp.com.au>
In-Reply-To: <20020723142704.B14323@suse.de>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
	<3D3BE421.3040800@evision.ag>
	<20020722160118.G6428@redhat.com>
	<20020723142704.B14323@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002 14:27:04 +0200
Dave Jones <davej@suse.de> wrote:

> On Mon, Jul 22, 2002 at 04:01:18PM -0400, Benjamin LaHaise wrote:
>  > On Mon, Jul 22, 2002 at 12:53:21PM +0200, Marcin Dalecki wrote:
>  > > - Fix a bunch of places where there are trailing "," at the
>  > >    end of enum declarations.
>  > 
>  > Please don't apply this.  By leaving the trailing "," on enums, additional 
>  > values can be added by merely inserting an additional + line in a patch, 
>  > otherwise there are excess conflicts when multiple patches add values to 
>  > the enum.
> 
> Gratuitous 'cleanups' with no real redeeming feature also have another
> downside which a lot of people seem to overlook.  They completely screws
> over anyone who also has a pending patch in that area if Linus applies it.

Yes.  It particularly sucks on the "maintainerless" core code which is always
in flux.  This is also why I generally reject whitespace-cleanup patches,
and originally rejected the "doesnt" patches (I got convinced by the pedants).

OTOH, 90% of kernel code is copied from elsewhere, so janitorial cleanups
*are* worthwhile, as long as they are one-liners, or fix a real problem.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
