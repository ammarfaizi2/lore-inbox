Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbSI3ShM>; Mon, 30 Sep 2002 14:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262820AbSI3ShL>; Mon, 30 Sep 2002 14:37:11 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:31241 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262816AbSI3ShK>; Mon, 30 Sep 2002 14:37:10 -0400
Date: Mon, 30 Sep 2002 19:42:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Chuck Lever <cel@netapp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] 2.4.20 Direct IO patch for NFS. (Note: a trivial API change...)
Message-ID: <20020930194227.A22095@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Chuck Lever <cel@netapp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux FSdevel <linux-fsdevel@vger.kernel.org>,
	NFS maillist <nfs@lists.sourceforge.net>
References: <15768.39196.468797.249573@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15768.39196.468797.249573@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Sep 30, 2002 at 08:34:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 08:34:04PM +0200, Trond Myklebust wrote:
> 
> Hi Marcelo,
> 
>   The following patch implements direct I/O for NFS as a compilation option.
> It does not in any way touch the standard NFS read/write code, however it
> does change the interface for generic direct I/O: Instead of taking a
> 'struct inode' argument, we need to take the full 'struct file' in order
> to be able to pass the RPC credential information down to the NFS layer.

I don't think changing the filesystem entry points during 2.4 is an option.

