Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUHBXtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUHBXtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUHBXtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:49:22 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:57027 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264503AbUHBXtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:49:07 -0400
Date: Tue, 3 Aug 2004 00:48:27 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Ian Romanick <idr@us.ibm.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
In-Reply-To: <410E81C3.2070804@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0408030040030.27728@skynet>
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com>
 <410E81C3.2070804@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> If this is something that we really want to pursue, someone needs to dig in
> and figure out:
>
> 1. How much / which code can be "trivially" shared?
> 2. How much / which code can be shared with very little work?
> 3. How much / which code would we rather get a root-canal than try to make
> shared?
>
> The concern has been that, by making a "generic" library layer, we'd actually
> make the DRM more difficult to maintain.  Nobody has really had the time to do
> the research required to either substantiate or refute those claims.  Based on
> the little experience I have in the DRM, I tend to believe them.

I'm going to agree with Ian here, making a generic library layer is going
to make maintaining  the DRM a full time job as opposed to the 5-6 hrs a
week I do on it ... also the change to a library needs to be done in
little steps, removing something from one place and adding it to another,
a big code-drop from the DRI CVS is not going to be acceptable to anyone,
however breaking things in the kernel tree is also not going to be...

So if people are proposing a complete DRM re-write, then what I forsee has
to happen is, a new development tree is setup, the code is beaten into shape,
we rename the project something else like ghm (graphics hardware manager -
you heard it here first :-), we import it into the kernel and deprecate
the DRM in-kernel, maybe we can develop it in the kernel tree as
(EXPERIMENTAL), then everyone can give out about it while the work is in
progress as opposed to when we are finished it ...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

