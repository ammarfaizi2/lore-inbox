Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWBAOxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWBAOxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbWBAOxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:53:12 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:10967 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161067AbWBAOxM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:53:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U8tZPLgQgH4bMwcn1RY2EUqw4BwBIupyHP39Tt0KJ+wkW7kOxFB1wMgvpLqJW44L4yFt1CwQM8oGxVV3pK9Ksz4PvJZRXCMpcKf9BABfYuBXtoDteG8ZfwWeXWTu6CaDshr52YkhBKBYVDdrPCGm70chASahASGIiU/XDsaktEQ=
Message-ID: <58cb370e0602010653g3c60b2ffoa9a84f83c7af45c1@mail.gmail.com>
Date: Wed, 1 Feb 2006 15:53:10 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@redhat.com>
Subject: Re: [patch] SGIIOC4 limit request size
Cc: Jeremy Higdon <jeremy@sgi.com>, Jes Sorensen <jes@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060201133917.GA27011@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <yq0vevzpi8r.fsf@jaguar.mkp.net>
	 <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
	 <20060201104913.GA152005@sgi.com>
	 <58cb370e0602010308o4cde24aeg8d629b1b3d45cdd3@mail.gmail.com>
	 <20060201111754.GB152005@sgi.com>
	 <58cb370e0602010326k265ef278k4010df13fb5adf8c@mail.gmail.com>
	 <20060201113607.GF152005@sgi.com>
	 <20060201133917.GA27011@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Alan Cox <alan@redhat.com> wrote:
> On Wed, Feb 01, 2006 at 03:36:07AM -0800, Jeremy Higdon wrote:
> > Here's one that removes xcount.  It seems to work too.
> > Should we set hwif->rqsize to 256, or are we pretty safe in
> > expecting that the default won't rise?  The driver should be
>
> 255 is the safest for LBA28 devices because a small number incorrectly
> interpret 0 (meaning 256) as 0. And that can have unfortunate results

We can blacklist vulnerable devices if needed.
We have been using 256 for a long time now.
