Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285408AbRLSTWl>; Wed, 19 Dec 2001 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285412AbRLSTWc>; Wed, 19 Dec 2001 14:22:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57676 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285408AbRLSTWU>; Wed, 19 Dec 2001 14:22:20 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <Pine.GSO.4.21.0112191153280.11104-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Dec 2001 12:01:56 -0700
In-Reply-To: <Pine.GSO.4.21.0112191153280.11104-100000@weyl.math.psu.edu>
Message-ID: <m1vgf3uj8b.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On 19 Dec 2001, Eric W. Biederman wrote:
> 
> > I have alarm bells ringing in my gut saying there are pieces of your
> > proposal that are on the edge of being overly complex... But without
> > source I can't really say.  Arbitrary NULL padding between images is
> > cool but why?
> 
> 	Alignment that might be wanted by loaders.  Take that with hpa - for
> all I care it's a non-issue.  while(!*p) p++; added before p = handle_part(p);
> in the main loop...

Right there are definitely cases where it makes sense, and it isn't too bad.

My basic design filter checks to see if there if there is one feature per
requirement.  At one feature per requirement it is a uninspired design.  At less
than one feature per requirement it approaches an elegant design.  At greater
than one feature per requirement it approaches a crap design.

The whole moving excess kernel code into user space, and use cpio
instead of a raw disk image part is elegant.  I just don't want the
idea to loose it in the small details.

And you have mentioned enough small features my reaction is to want to review
the code and think it through.  So I'll have to look it over very closely next
time you post a patch.

Eric
