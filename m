Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUBRDPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUBRDPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:15:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263205AbUBRDPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:15:24 -0500
Message-ID: <4032D893.9050508@zytor.com>
Date: Tue, 17 Feb 2004 19:14:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org> <c0uj52$3mg$1@terminus.zytor.com> <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 18 Feb 2004, H. Peter Anvin wrote:
> 
>>Well, we don't want to support a bunch of hacks to make it behave like
>>Windows if what Windows does doesn't make sense.
> 
> 
> I'd disagree, for a very simple reason: case-insensitivity itself simply 
> does not make sense, so the _only_ reason for having a bunch of hacks is 
> literally to support windows file exports and nothing else.
> 
> I obviously agree with the fact that we should _not_ put those hacks into 
> the VFS layer proper - we should keep them as a separate thing, and we 
> should make it clear that it makes no sense _except_ for Windows 
> compatibility.
> 
> Think of it as nothing more than a binary compatibility layer, the same 
> way we have hooks to support "lcall 7,0" for binary compatibility with 
> some silly (and much less interesting) x86 OSes through external modules.
> 

Well, this is also true :)  I still say it belongs in userspace.

For 100% bug-compatibility with Windows, though, it is probably
worthwhile to have the filename in the native filesystem be not what a
Windows user would see, but rather the normalized filename.  That makes
a userspace implementation much easier.

	-hpa

