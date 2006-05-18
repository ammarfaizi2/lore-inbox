Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWERSFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWERSFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWERSFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:05:53 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:56032 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932110AbWERSFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:05:52 -0400
Subject: Re: HELP! vfs_readv() issue
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140605171444o66de4caqdbe38e028aed94bf@mail.gmail.com>
References: <4ae3c140605151657m152c0e7bl7f52e2a2def0aeca@mail.gmail.com>
	 <20060516043107.GA5321@taniwha.stupidest.org>
	 <4ae3c140605171444o66de4caqdbe38e028aed94bf@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 18 May 2006 21:00:57 +0300
Message-Id: <1147975279.3073.4.camel@85.65.211.169.dynamic.barak-online.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 17:44 -0400, Xin Zhao wrote:
> Thank you for your care. What I am trying to do is to rewrite NFS in
> the virtual machine environment so that network communication can be
> replaced with inter-VM communication.
> 
> But after I remove the original rpc stuff, I ran into some strange
> problem, including this one.  Interesting thing is that I noticed that
> even with standard NFS implementation, it is still possible that
> nfsd_read() return resp->count to be 0. At this time, eof is also
> equal to 1. This seems to be right since NFSD already reach the end of
> the file. But question is since 0 byte is read this time, NFS should
> detect EOF in previous read. Why need one more read?
> 
> Xin

How are you reading the file?  Some programs (I believe 'cat' is one of
them) will read a file until 0 is returned.  Try writing a small C
program to read a file until EOF and see if the behavior changes.

Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/

