Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSIEAcR>; Wed, 4 Sep 2002 20:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSIEAcR>; Wed, 4 Sep 2002 20:32:17 -0400
Received: from dsl-213-023-038-092.arcor-ip.net ([213.23.38.92]:44193 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315758AbSIEAcN>;
	Wed, 4 Sep 2002 20:32:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Benjamin LaHaise <bcrl@redhat.com>, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: Large block device patch, part 1 of 9
Date: Thu, 5 Sep 2002 02:38:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Pavel Machek <pavel@suse.cz>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <825516963@toto.iv> <15734.37217.686498.162782@wombat.chubb.wattle.id.au> <20020904200424.O1394@redhat.com>
In-Reply-To: <20020904200424.O1394@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mkfj-000627-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 02:04, Benjamin LaHaise wrote:
> On Thu, Sep 05, 2002 at 09:04:01AM +1000, Peter Chubb wrote:
> > Unfortunately, this doesn't really buy you much ---- standard C type
> > promotion rules mean that whatever (within reason) you pass to
> > llsect() will work without warning.
> 
> Not if someone changes a variable to a pointer by accident without 
> updating the printk.  It does happen.

The thing is, I don't see why we should be building castles and cathedrals
around printk.  Just cast to the wider value, if you get it wrong you have
lost exactly what?  Are people feeding the output of dmesg into scripts
that their systems depend upon?  If so, we need to let evolution do its
work.

If this had something to do with how the kernel worked, it might be worth
inventing a new feature.

-- 
Daniel
