Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbSJGRUv>; Mon, 7 Oct 2002 13:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbSJGRUB>; Mon, 7 Oct 2002 13:20:01 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:62993 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262585AbSJGRT1>; Mon, 7 Oct 2002 13:19:27 -0400
Date: Mon, 7 Oct 2002 18:25:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve Pratt <slpratt@us.ibm.com>
Cc: Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021007182500.A20242@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Pratt <slpratt@us.ibm.com>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <OF57AD2670.5A531CF2-ON85256C48.006578C9@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF57AD2670.5A531CF2-ON85256C48.006578C9@pok.ibm.com>; from slpratt@us.ibm.com on Fri, Oct 04, 2002 at 01:45:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> and raid and LVM them all you want, and you don't consume 1000*layers
> >> device nodes.
> 
> >I don't think it's a benefit but really ugly.  There is no reason to now

sorry, that "now" should have been a 'not'.

> >allow access to the lower layers.  How do I e.g. write a new volume label
> to
> >the lower level devices?
> 
> I am not sure I understand your question.  Did you mean that there does not
> appear to be a **way** to access lower level devices or did you really mean
> no reason to do so?

Sorry again for above typo - it makes my whole statement worthless..

To clarify: I think not having device nodes for anything but the uppermost
layer of evms volumes is a bad idea.  This does not only make it impossible
to access those normally from userspace but also makes evms duplicate
code in the block layers as we already have stacking support there.
