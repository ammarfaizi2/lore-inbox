Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWEQVoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWEQVoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 17:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWEQVoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 17:44:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:22549 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751161AbWEQVoI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:44:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aN0qEERS0KCR0X4Bf51EiePb8wQr4vmGKG222Iyvj0gKjF5X6MU9awmIlNjJMSVyIAM/Fdy5lqekcppyfbPqb6tlpDyUg7lPqRe1+3scRiQSByhNG64DykF6hi9P+yoxuJdu/uDdyLsSo1UVXrI6tqKlBskqHq+nzWjtlZp+23A=
Message-ID: <4ae3c140605171444o66de4caqdbe38e028aed94bf@mail.gmail.com>
Date: Wed, 17 May 2006 17:44:07 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Chris Wedgwood" <cw@f00f.org>
Subject: Re: HELP! vfs_readv() issue
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060516043107.GA5321@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140605151657m152c0e7bl7f52e2a2def0aeca@mail.gmail.com>
	 <20060516043107.GA5321@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your care. What I am trying to do is to rewrite NFS in
the virtual machine environment so that network communication can be
replaced with inter-VM communication.

But after I remove the original rpc stuff, I ran into some strange
problem, including this one.  Interesting thing is that I noticed that
even with standard NFS implementation, it is still possible that
nfsd_read() return resp->count to be 0. At this time, eof is also
equal to 1. This seems to be right since NFSD already reach the end of
the file. But question is since 0 byte is read this time, NFS should
detect EOF in previous read. Why need one more read?

Xin

On 5/16/06, Chris Wedgwood <cw@f00f.org> wrote:
> On Mon, May 15, 2006 at 07:57:21PM -0400, Xin Zhao wrote:
>
> > I am writing a file system, but vfs_read() sometimes return 0. What
> > could cause this problem?
>
> EOF?
>
