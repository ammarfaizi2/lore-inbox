Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUHJEIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUHJEIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUHJEIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:08:17 -0400
Received: from hera.kernel.org ([63.209.29.2]:61903 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267415AbUHJEIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:08:15 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: BUG: bsd pts now climbs continuously
Date: Tue, 10 Aug 2004 04:07:33 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cf9hm5$tsu$1@terminus.zytor.com>
References: <Pine.LNX.4.30.0408091609100.31211-200000@link> <1092086245.14770.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1092110854 30623 127.0.0.1 (10 Aug 2004 04:07:34 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 10 Aug 2004 04:07:34 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1092086245.14770.2.camel@localhost.localdomain>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> On Llu, 2004-08-09 at 21:30, jdh wrote:
> > While I'm sure the security issues are valid?  I do question completely
> > changing the functionality.  I doubt changing the pts/n numbers
> > helps those looking for backward compatibility at all.
> 
> ssh breaks at 9999 which is fun too. It runs out of buffer space
> although because its been properly coded it doesn't overrun it just
> starts corrupting utmp
> 

This I believe is a glibc bug, and really needs to be fixed.
Unfortunately glibc's handling of utmp is just incredibly broken.

	-hpa

