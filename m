Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUGHLPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUGHLPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUGHLPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:15:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45265 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261159AbUGHLPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:15:22 -0400
Date: Thu, 8 Jul 2004 12:15:21 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gabriel Paubert <paubert@iram.es>
Cc: tom st denis <tomstdenis@yahoo.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040708111521.GK12308@parcelfarce.linux.theplanet.co.uk>
References: <20040707184737.GA25357@infradead.org> <20040707185340.42091.qmail@web41112.mail.yahoo.com> <20040708093249.GC32629@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708093249.GC32629@iram.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 11:32:50AM +0200, Gabriel Paubert wrote:

> Yes, I know and I use BK. But given the fact that you insult me for 
> better knowing C rules than you, I'm seriously considering switch 
> to subversion or arch instead.
> 
> Argh, I've mentioned BK. There should be a Goldwin's law equivalent
> for BitKeeper on lkml ;-)

Godwin, surely?

Anyway, if you think that suckversion authors knew C...  Try to read their
decoder/parser/whatever you call the code handling the data stream obtained
from other end of connection.  _Especially_ when it comes to signedness
(of integers, mostly).

> - the aforementioned fgetc/getc/getchar issues.

... have nothing to do with char; getc() has more legitimate return values
than char can represent.  No matter whether it's signed or unsigned, if
you have
	... char c;
	...
	c = getc();
you have a bug - Dirichlet Principle bites you anyway.
