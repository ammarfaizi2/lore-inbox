Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262426AbTCZTys>; Wed, 26 Mar 2003 14:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbTCZTys>; Wed, 26 Mar 2003 14:54:48 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:34822 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262426AbTCZTyq>; Wed, 26 Mar 2003 14:54:46 -0500
Date: Wed, 26 Mar 2003 20:05:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] s390 update (4/9): common i/o layer update.
Message-ID: <20030326200558.B21308@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <OF53EAB661.698F04AC-ONC1256CF5.0059F8AC@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF53EAB661.698F04AC-ONC1256CF5.0059F8AC@de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Mar 26, 2003 at 05:27:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 05:27:23PM +0100, Martin Schwidefsky wrote:
> 
> > > + typeof (chsc_area_ssd.response_block)
> > > +       *ssd_res = &chsc_area_ssd.response_block;
> >
> > Yikes!  Please use the actual type here instead of typeof()
> Trouble is that response_block is an anonymous structure. There
> is not type...

Then add one.

> > What about using GFP_KERNEL | __GFP_DMA instead?  This makes it
> > more clear that it's just a qualifier.
> Hmm, GFP_DMA and __GFP_DMA are equivalent. I don't quite see your
> point here.

The __GFP flags are modifiers, the GFP_ flags usually can be used standalone -
with the exception of GFP_DMA which shouldn't exist.

