Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUFRVP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUFRVP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUFRVM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:12:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:22983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264269AbUFRVJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:09:10 -0400
Date: Fri, 18 Jun 2004 14:08:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: matthew-lkml@newtoncomputing.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
In-Reply-To: <20040618205355.GA5286@newtoncomputing.co.uk>
Message-ID: <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org>
References: <20040618205355.GA5286@newtoncomputing.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jun 2004 matthew-lkml@newtoncomputing.co.uk wrote:
> 
> The main problem seems to be in ACPI, but I don't see any reason for
> printk to even consider printing _any_ non-printable characters at all.
> It makes all characters out of the range 32..126 (except for newline)
> print as a '?'.

How about emitting them as \xxx, so that you see what they are. And using 
a case-statement to make it easy and clear when to do exceptions (I think 
we should accept \t too, no?).

		Linus
