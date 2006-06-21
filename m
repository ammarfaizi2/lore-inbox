Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWFUL3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWFUL3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWFUL3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:29:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:61201 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751332AbWFUL3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:29:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PVnPRIzriEmhfTc5YRZfpJF1gUKrmUtSCtke9QsPwFvDqxtJ6ZuwUmmUTENjlgEa4oGS7s3sCt+oJO0hoe9KyKhOWdqPzBK4F5flMDcMbF5UEk93RzBlBTKlIt32rlgd/1qr5BlVgjqI17s7WGTrge/9bqvCO7eFKW+CqC8iU1E=
Message-ID: <6bffcb0e0606210429t3e78e88dqd637718e4e22b3f0@mail.gmail.com>
Date: Wed, 21 Jun 2006 13:29:21 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm1
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060621041758.4235dbc6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621034857.35cfe36f.akpm@osdl.org>
	 <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>
	 <20060621041758.4235dbc6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 21 Jun 2006 13:07:41 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > On 21/06/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
> > >
> > >
> > > - powerpc is bust (on g5, at least).  git-klibc is causing nash to fail on
> > >   startup and some later patch is causing a big crash (I didn't bisect that
> > >   one - later).
> > >
> > > - ia64 doesn't compile for me, due to git-klibc problems (a truly ancient
> > >   toolchain might be implicated).
> > >
> >
> > I have the similar problem here
> >
> > usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file
> > or directory
>
> That one's probably just a parallel kbuild race.  Type `make' again.
>

"make O=/dir" is culprit.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
