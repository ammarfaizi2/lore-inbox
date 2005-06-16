Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVFPXcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVFPXcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVFPXcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:32:25 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:55732 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261858AbVFPXcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 19:32:15 -0400
X-ORBL: [63.202.173.158]
Date: Thu, 16 Jun 2005 16:32:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: trmcneal@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <165572.73a4e5686a7ab70d16f3e50cdfb77252.ANY@taniwha.stupidest.org>
References: <061620052308.15335.42B2066C000DD5E200003BE72205886172040E0A020C039D9B@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061620052308.15335.42B2066C000DD5E200003BE72205886172040E0A020C039D9B@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 11:08:28PM +0000, trmcneal@comcast.net wrote:

> > I've been working with some tcp network test programs that have
> > multiple clients opening nonblocking sockets to a single server
> > port, sending a short message, and then closing the socket,
> > 100,000 times.  Since the socket is non-blocking, it generally
> > tries to connect and then does a poll since the socket is busy.
> > The test fails if the poll times out in 10 seconds.  It fails
> > consistently on Linux servers but succeeds on Solaris servers; the
> > client is a non-issue unless its loopback on the Linux server.

where is the code for this?  are you sure you're not overflowing the
listen backlog somewhere?  that would show up in some cases but not
all depending on latencies and local scheduler behavior
