Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVDZFbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVDZFbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDZFbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:31:46 -0400
Received: from smtp.istop.com ([66.11.167.126]:26293 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261243AbVDZFaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:30:07 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 0/7] dlm: overview
Date: Tue, 26 Apr 2005 01:30:16 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050425210915.GX32085@marowsky-bree.de>
In-Reply-To: <20050425210915.GX32085@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200504260130.17016.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 17:09, Lars Marowsky-Bree wrote:
> Now that we have two (or three) options with actual users, now is the
> right time to finally come up with sane and useful abstractions. This is
> great.

Great thought, but it won't work unless you actually read them all, which I 
hope is what you're proposing.

> With APIs, I think we do need a DLM-switch in the kernel, but also the
> DLMs should really seem much the same to user-space apps. From what I've
> seen, dlmfs is OCFS2 wasn't doing too badly there. The icing would of
> course be if even the configuration was roughly similar, and if OCFS2's
> configfs might prove valuable to other users too.

I'm a little skeptical about the chance of fitting an 11-parameter function 
call into a generic kernel plug-in framework.  Are those the exact same 11 
parameters that God intended?

While it would be great to share a single dlm between gfs and ocfs2 - maybe 
Lustre too - my crystal ball says that that laudable goal is unlikely to be 
achieved in the near future, whereas there isn't much choice but to sort out 
a common membership framework right now.

As far as I can see, only cluster membership wants or needs a common 
framework.  And I'm not sure that any of that even needs to be in-kernel.

Regards,

Daniel



> The cluster summit in June will certainly be a very ... exciting place.
> Let's hope this also stirs up KS a bit ;-)
>
> Oh, and just to anticipate that discussion, anyone who suggests to adopt
> the SAF AIS locking API into the kernel should be preemptively struck;
> that naming etc is just beyond words.
>
>
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>
