Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUCLXPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUCLXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:15:48 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59547 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263019AbUCLXPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:15:46 -0500
Subject: Re: [PATCH][RFC] fix BSD accounting (w/ long-term perspective ;-)
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: kernel@ragnark.vestdata.no, corliss@digitalmages.com,
       tim@physik3.uni-rostock.de
Content-Type: text/plain
Organization: 
Message-Id: <1079133615.2255.603.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Mar 2004 18:20:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> store a version number in the last byte of struct acct, which allows
> for a smooth transition to a new binary format when 2.7 comes out.
> For 2.7, extend uid/gid fields to 32 bit, report times in terms
> of AHZ=100 on all platforms (thus allowing to report times up to 1988 
> days), and remove the compatibility stuff from the kernel.

This is no good. The struct size varies. It is 64 bytes on
most architectures. It is likely to be larger on hppa, and
smaller on m68k or arm.

The second byte is available, as padding on every arch.
Use that instead.


