Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUKIOCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUKIOCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKIOCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:02:38 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:18187 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261442AbUKIOC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:02:28 -0500
Date: Tue, 9 Nov 2004 14:02:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 17/20] FRV: Better mmap support in uClinux
Message-ID: <20041109140217.GB5388@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20041109125747.GB4867@infradead.org> <20040401020550.GG3150@beast> <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com> <15110.1100008526@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15110.1100008526@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 01:55:26PM +0000, David Howells wrote:
> 
> > > +/* list of shareable VMAs */
> > > +LIST_HEAD(nommu_vma_list);
> > > +DECLARE_RWSEM(nommu_vma_sem);
> > 
> > As I told you this absolutely should be static.
> 
> Yes, you did. I ignored you. You also said that I shouldn't put any proc stuff
> in mm/.

I didn't say you should put any proc stuff into mm/ but that's it propably
more readablewhen kept in fs/proc/.

But again - global lists are really, really bad.  If you want to access it
add proper acessor functions.

