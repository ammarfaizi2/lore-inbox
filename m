Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318902AbSHSOs3>; Mon, 19 Aug 2002 10:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318904AbSHSOs3>; Mon, 19 Aug 2002 10:48:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:7943 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318902AbSHSOs2>; Mon, 19 Aug 2002 10:48:28 -0400
Date: Mon, 19 Aug 2002 15:52:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com, viro@math.psu.edu
Subject: Re: Need more symbols to be exported out of kernel
Message-ID: <20020819155226.A26430@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
	reiserfs-dev@namesys.com, viro@math.psu.edu
References: <20020819184208.A11022@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020819184208.A11022@namesys.com>; from green@namesys.com on Mon, Aug 19, 2002 at 06:42:08PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 06:42:08PM +0400, Oleg Drokin wrote:
> Hello!
> 
>    I have implemented file_operations->write() function for reiserfs for
>    linux kernel v2.4, and it seems I need these symbols to be exported
>    out of kernel for a case when reiserfs is built as a module:
>    generic_osync_inode

sounds like a good idea.

>    remove_suid

trivial inline,  either move it to a header or copy & paste.

>    block_commit_write

fine with me.

>    I need block_commit_write just because generic_commit_write is doing
>    some extra stuff I'd better do myself.
>    Will the patch to export these symbols be accepted? (should these be
>    exported as GPL sysmbols or not?).

IMHO no _GPL, they are not different from other generic filesystem code.

