Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSJMNFq>; Sun, 13 Oct 2002 09:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbSJMNFq>; Sun, 13 Oct 2002 09:05:46 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:58631 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261517AbSJMNFp>; Sun, 13 Oct 2002 09:05:45 -0400
Date: Sun, 13 Oct 2002 14:11:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: shadow@andrew.cmu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes for 2.4.19-pre5-ac3)
Message-ID: <20021013141135.A15708@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	shadow@andrew.cmu.edu, linux-kernel@vger.kernel.org
References: <3DA89B05.mailESG1QJVJI@johnstown.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA89B05.mailESG1QJVJI@johnstown.andrew.cmu.edu>; from shadow@andrew.cmu.edu on Sat, Oct 12, 2002 at 05:58:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 05:58:29PM -0400, shadow@andrew.cmu.edu wrote:
> And then, xyzzy, and nothing happened.
> Anyhow, this implements more or less exactly what's in 2.4.19 for nfs,
> and adds the necessary wrapper for s390x.

Please don't put it into the NFS files.  And I'd suggest to use u32
instead of long for the interface, to simplify 32bit compatiblity.

Also, what exactly is this call doing?  I seems to be yet another
multiplexer syscall and we already have more than enough of those.

