Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbTCZQ0s>; Wed, 26 Mar 2003 11:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbTCZQ0s>; Wed, 26 Mar 2003 11:26:48 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:62351 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261768AbTCZQ0r>; Wed, 26 Mar 2003 11:26:47 -0500
Date: Wed, 26 Mar 2003 17:37:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] s390 update (4/9): common i/o layer update.
Message-ID: <20030326163732.GK20098@wohnheim.fh-wedel.de>
References: <OF53EAB661.698F04AC-ONC1256CF5.0059F8AC@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF53EAB661.698F04AC-ONC1256CF5.0059F8AC@de.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 March 2003 17:27:23 +0100, Martin Schwidefsky wrote:
> 
> > > + if (sch->lpm == 0)
> > > +       return -ENODEV;
> > > + else
> > > +       return -EACCES;
> >
> > I'd write this as return (sch->lpm ? -EACCES : -ENODEV), but maybe I'm
> > just too picky..
> No, you are not. return (sch->lpm ? -EACCES : -ENODEV) is better.

Are the brackets really necessary? This is highly personal, but I
spend a few second "stubling" over them, which makes the code less
readable for me.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
