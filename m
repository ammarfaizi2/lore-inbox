Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSHMN2P>; Tue, 13 Aug 2002 09:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSHMN2P>; Tue, 13 Aug 2002 09:28:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45299 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315370AbSHMN2O>;
	Tue, 13 Aug 2002 09:28:14 -0400
Date: Tue, 13 Aug 2002 18:59:21 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1 of 2] Scalable statistics counters
Message-ID: <20020813185921.F27366@in.ibm.com>
References: <20020812183524.B1992@in.ibm.com> <20020812144605.A4595@infradead.org> <20020813013546.A7819@in.ibm.com> <20020812210952.A17329@infradead.org> <20020813110725.A10332@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020813110725.A10332@in.ibm.com>; from dipankar@in.ibm.com on Tue, Aug 13, 2002 at 11:07:25AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 11:07:25AM +0530, Dipankar Sarma wrote:
> ... 
> Yes, that I learnt by looking at mounts_open(), the problem is how
> do I get the statctr_pentry (or statctr_group if you like) in
> the open method ? It seems to me that in order to do this, we
> need the following -
> 
> 1. An exported wrapper create_statctr_entry() around 
>    create_seq_entry() code that sticks the statctr_group pointer into
>    proc_entry->data.
> 2. Some way to get the proc entry from the inode in statctr_open()
>    and stick it to seq_file->private for seq_file methods to use.
> 
> Is this understanding correct or is there a better and simpler
> way to do this ?
>

Christoph,
I have used the above mentioned method now, alongwith the PDE macro to get
the proc_dir_entry from the inode.  I'll post the patch after testing it..

Thanks,
Kiran
