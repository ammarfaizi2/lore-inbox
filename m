Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWFOA2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWFOA2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWFOA2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:28:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:34692 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWFOA2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:28:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FGiK4oJdaBOxxH3lGRyIo2L5s/0kgNCWPH73xRg81iL+6v0fsGtJNP/ZxdCV/IC0NxpuZvHMJArFHP2EU/fTVi9dunz6nsbsEdtFhj4u6AjNUygEdq1Ztl5TbGW+mEgHjkkaB8HL1PRLlxuZqvUaqfwj9YtcZOxClw3zdkWT5zM=
Message-ID: <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com>
Date: Wed, 14 Jun 2006 17:28:31 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Matthew Frost" <artusemrys@sbcglobal.net>,
       "Alex Tomas" <alex@clusterfs.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060614213431.GF4950@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	 <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org>
	 <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net>
	 <20060609181426.GC5964@schatzie.adilger.int>
	 <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz>
	 <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com>
	 <20060614213431.GF4950@ucw.cz>
X-Google-Sender-Auth: 68ee01c9a03825db
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/06, Pavel Machek <pavel@ucw.cz> wrote:
> Passes 8 hours of me trying to intentionally break it with weird,
> artifical disk corruption.
>
> I even have script somewhere.

Ok, thanks for clarifying.

> > Unless I'm misunderstanding something, JFS also has a
> > working fsck
> > (which has actually performed successful repair of
> > real-world
> > filesystem corruption for me, although I haven't used it
> > as much as
> > e2fsck or xfs_repair).
>
> ...like, if it repaired 100 different, non-trivial corruptions, that
> would be argument.

In the case of XFS, I've repaired maybe two dozen (or so) corruptions
that might be non-trivial (in most of the cases, the filesystem
wouldn't even mount before the repair).

> fsck.ext2 survives my torture (in some versions). fsck.vfat never
> worked for me (likes to segfault), fsck.reiser never worked for me.

BTW, I actually have a test filesystem here (an e2image from an actual
filesystem I encountered once) that used to cause e2fsck 1.36/1.37 to
segfault. Strangely, more ancient versions (like what ships in Red Hat
7.2) were able to repair it without segfaulting. In a few days, once
other stuff calms down for me, I need to revisit that and see if the
bug still exists with 1.39.
-- 
-Barry K. Nathan <barryn@pobox.com>
