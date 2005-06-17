Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVFQBnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVFQBnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVFQBnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:43:53 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:54739 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261886AbVFQBnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:43:51 -0400
Message-ID: <42B22B75.7020509@comcast.net>
Date: Thu, 16 Jun 2005 18:46:29 -0700
From: Tom McNeal <trmcneal@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: your mail
References: <061620052308.15335.42B2066C000DD5E200003BE72205886172040E0A020C039D9B@comcast.net> <165572.73a4e5686a7ab70d16f3e50cdfb77252.ANY@taniwha.stupidest.org>
In-Reply-To: <165572.73a4e5686a7ab70d16f3e50cdfb77252.ANY@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll look at that.  This occurs on all Linux platforms, including a generic
2.4.31 I downloaded from kernel.org. The user test is trivial, just doing
the nonblocking connect, the poll, the send, and then the close, in that loop.

Tom

Chris Wedgwood wrote:
> On Thu, Jun 16, 2005 at 11:08:28PM +0000, trmcneal@comcast.net wrote:
> 
> 
>>>I've been working with some tcp network test programs that have
>>>multiple clients opening nonblocking sockets to a single server
>>>port, sending a short message, and then closing the socket,
>>>100,000 times.  Since the socket is non-blocking, it generally
>>>tries to connect and then does a poll since the socket is busy.
>>>The test fails if the poll times out in 10 seconds.  It fails
>>>consistently on Linux servers but succeeds on Solaris servers; the
>>>client is a non-issue unless its loopback on the Linux server.
> 
> 
> where is the code for this?  are you sure you're not overflowing the
> listen backlog somewhere?  that would show up in some cases but not
> all depending on latencies and local scheduler behavior
> 

-- 
Tom McNeal
(650)906-0761(cell)
(650)964-8459(fax)
Email: trmcneal@comcast.net
