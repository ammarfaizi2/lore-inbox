Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937958AbWLGCJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937958AbWLGCJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937956AbWLGCJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 21:09:04 -0500
Received: from station18k.dscga.com ([192.24.222.18]:41577 "EHLO
	suzuka.mcnaught.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S937951AbWLGCJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 21:09:03 -0500
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
 arch doesn't support it
References: <20061206195820.GA15281@flint.arm.linux.org.uk>
	<20061206213626.GE3013@parisc-linux.org>
	<Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
	<20061206220532.GF3013@parisc-linux.org>
	<Pine.LNX.4.64.0612070130240.1868@scrub.home>
	<Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612070203520.1867@scrub.home>
	<Pine.LNX.4.64.0612061717030.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612070219540.1867@scrub.home>
	<Pine.LNX.4.64.0612061735150.3542@woody.osdl.org>
	<20061207014428.GH3013@parisc-linux.org>
From: Douglas McNaught <doug@mcnaught.org>
Date: Wed, 06 Dec 2006 21:09:02 -0500
In-Reply-To: <20061207014428.GH3013@parisc-linux.org> (Matthew Wilcox's
 message of "Wed, 6 Dec 2006 18:44:28 -0700")
Message-ID: <8764colao1.fsf@suzuka.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> writes:

> On Wed, Dec 06, 2006 at 05:36:29PM -0800, Linus Torvalds wrote:
>> Or are you saying that gcc aligns normal 32-bit entities at 
>> 16-bit alignment? Neither of those sound very likely.
>
> alignof(u32) is 2 on m68k.  Crazy, huh?

The original 68000 had a 16-bit bus (but 32-bit registers), which is
probably why it's that way.

-Doug
