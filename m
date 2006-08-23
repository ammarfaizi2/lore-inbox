Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWHWQJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWHWQJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWHWQJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:09:32 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:48841 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S965012AbWHWQJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:09:32 -0400
Date: Wed, 23 Aug 2006 08:53:21 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823155321.GD1733@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <p73fyfn7nzz.fsf@verdi.suse.de> <20060823102932.GA697@frankl.hpl.hp.com> <20060823152555.GA32725@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823152555.GA32725@infradead.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

On Wed, Aug 23, 2006 at 04:25:55PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 23, 2006 at 03:29:32AM -0700, Stephane Eranian wrote:
> > > > +#define PFM_EM64T_PEBS_SMPL_UUID { \
> > > > +	0x36, 0xbe, 0x97, 0x94, 0x1f, 0xbf, 0x41, 0xdf,\
> > > > +	0xb4, 0x63, 0x10, 0x62, 0xeb, 0x72, 0x9b, 0xad}
> > > 
> > > What does it need the UUID for?
> > > 
> > Every sampling format is identified by a UUID. This  is how an
> > application can identify the format it wants to use when it
> > creates a context.
> 
> Please use a string name, just like every other interface for
> such selections.

What are the advantages at the syscall level (i.e., copy_user, 
format parsing) compared to a 16-entry byte array?

We are passing that uuid into a struct:

struct pfarg_ctx {
        __u8		ctx_smpl_buf_id[16];
        __u32		ctx_flags;
        __s32           ctx_fd;
        __u64           ctx_smpl_buf_size;
        __u64           ctx_reserved3[12];
};

-- 
-Stephane
