Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSCDEWx>; Sun, 3 Mar 2002 23:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291306AbSCDEWp>; Sun, 3 Mar 2002 23:22:45 -0500
Received: from rj.sgi.com ([204.94.215.100]:56536 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S291272AbSCDEWb>;
	Sun, 3 Mar 2002 23:22:31 -0500
Date: Sun, 3 Mar 2002 20:21:18 -0800 (PST)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10203032021.ZM443706@classic.engr.sgi.com>
In-Reply-To: Daniel Phillips <phillips@bonn-fries.net>
        "Re: [PATCH] 2.4.x write barriers (updated for ext3)" (Mar  3, 11:11pm)
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> 
	<E16heCm-0000Q5-00@starship.berlin>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 3, 11:11pm, Daniel Phillips wrote:
> I have a standing offer from at least one engineer to make firmware changes 
> to the drives if it makes Linux work better.  So a reasonable plan is: first 
> know what's ideal, second ask for it.  Coupled with that, we'd need a way of 
> identifying drives that don't work in the ideal way, and require a fallback.
> 
> In my opinion, the only correct behavior is a write barrier that completes
> when data is on the platter, and that does this even when write-back is
> enabled.  Surely this is not rocket science at the disk firmware level.  Is
> this or is this not the way ordered tags were supposed to work?


Ordered tags just specify ordering in the command stream.  The WCE bit
specifies when the write command is complete.  I have never heard of
any implied requirement to flush to media when a drive receives an
ordered tag and WCE is set.  It does seem like a useful feature to have
in the standard, but I don't think it's there.

So if one vendor implements those semantics, but the others don't where
does that leave us?

jeremy
