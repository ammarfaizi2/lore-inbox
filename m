Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVCOQSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVCOQSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVCOQR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:17:57 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:13288 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261380AbVCOQPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:15:44 -0500
Date: Tue, 15 Mar 2005 16:15:42 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Dave Jones <davej@redhat.com>
Cc: Andrew Clayton <andrew@digital-domain.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm lockups since 2.6.11-bk2
In-Reply-To: <20050315143629.GA27654@redhat.com>
Message-ID: <Pine.LNX.4.58.0503151610560.443@skynet>
References: <Pine.LNX.4.58.0503151033110.22756@skynet> <20050315143629.GA27654@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  >
>  > I might get time to do a code review, my main worry is that all the
>  > problems reported with those patches in -mm made it into the patchset that
>  > went into Linus.. mainly things like forgetting to memset certain
>  > structures to 0 and sillies like that...
>
> I saw one report where the recent drm security hole fix broke dri
> for one user.  Whilst it seems an isolated incident, could this have
> more impact than we first realised ?

the radeon security changes? I've gotten no bad feedback on those neither
has dri-devel, so I've assumed they were all fine (usually radeon bug
reports get back fairly quickly as everyone has one ..),

the multi-bridge stuff is definitely broken as I've seen radeon and r128
reports on it .. and it looks most like 2.6.11-bk2 broke things and I
haven't merged anything until -bk7 ...

>
> Worse case scenario we can drop out the multi-bridge support for now
> if it needs work. Mike left SGI now, so we'll need to find someone else
> with access to a Prism to make sure it still works correctly on a
> real multi-gart system.

I'd like to make it work I'm sure it is some thing small wrong, but I've
no access for > 1 week to my radeon machine so unless someone else picks
it up we may need to drop it for now..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

