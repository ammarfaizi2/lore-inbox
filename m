Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUBRDEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUBRDEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:04:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:57045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262827AbUBRDDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:03:32 -0500
Date: Tue, 17 Feb 2004 19:03:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <c0uj52$3mg$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org>
 <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org>
 <c0uj52$3mg$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, H. Peter Anvin wrote:
> 
> Well, we don't want to support a bunch of hacks to make it behave like
> Windows if what Windows does doesn't make sense.

I'd disagree, for a very simple reason: case-insensitivity itself simply 
does not make sense, so the _only_ reason for having a bunch of hacks is 
literally to support windows file exports and nothing else.

I obviously agree with the fact that we should _not_ put those hacks into 
the VFS layer proper - we should keep them as a separate thing, and we 
should make it clear that it makes no sense _except_ for Windows 
compatibility.

Think of it as nothing more than a binary compatibility layer, the same 
way we have hooks to support "lcall 7,0" for binary compatibility with 
some silly (and much less interesting) x86 OSes through external modules.

		Linus
