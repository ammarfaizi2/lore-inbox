Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310518AbSCEHl0>; Tue, 5 Mar 2002 02:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310516AbSCEHlQ>; Tue, 5 Mar 2002 02:41:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7437 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310515AbSCEHlK>;
	Tue, 5 Mar 2002 02:41:10 -0500
Date: Tue, 5 Mar 2002 08:40:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020305074042.GB716@suse.de>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <10203032209.ZM424559@classic.engr.sgi.com> <20020304165216.A1444@redhat.com> <E16hwzT-0000et-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hwzT-0000et-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04 2002, Daniel Phillips wrote:
> > FUA is not available on WRITE6, only WRITE10 or WRITE12 commands.
> 
> I'm having a little trouble seeing the difference between WRITE10, WRITE12
> and WRITE16.  WRITE6 seems to be different only in not garaunteeing to 
> support the FUA (and one other) bit.  I'm reading the Scsi Block Commands

WRITE6 was deprecated because there is only one byte available to set
transfer size. Enter WRITE10. WRITE12 allows the use of the streaming
performance settings, that's the only functional difference wrt WRITE10
iirc.

> (Side note: how nice it would be if t10.org got a clue and posted their
> docs in html, in addition to the inconvenient, unhyperlinked, proprietary
> format pdfs.)

See the mtfuji docs as an example for how nicely pdf's can be setup too.
The thought of substituting that for a html version makes me want to
barf.

-- 
Jens Axboe

