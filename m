Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUFIQxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUFIQxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUFIQxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:53:22 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:17653 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265840AbUFIQxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:53:19 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Robert White" <rwhite@casabyte.com>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Wed, 9 Jun 2004 11:53:05 -0500
X-Mailer: KMail [version 1.2]
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com>
MIME-Version: 1.0
Message-Id: <04060911530500.08612@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 June 2004 16:50, Robert White wrote:
> I would think that having an easy call to disable the NX modification would
> be both safe and effective.  That is, adding a syscall (or whatever) that
> would let you mark your heap and/or stack executable while leaving the new
> default as NX, is "just as safe" as flagging the executable in the first
> place.

ahhhh no.

The first attack against a vulerable server  would be to load a string
on the stack that would:
1. have address of the syscall to turn off NX, then return to the stack.
2. have normal worm/virus code following.

