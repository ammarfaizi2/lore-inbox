Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUCNApJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbUCNApJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:45:09 -0500
Received: from twin.jikos.cz ([213.151.79.26]:61906 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S263232AbUCNApF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:45:05 -0500
Date: Sun, 14 Mar 2004 01:44:51 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: Dave Jones <davej@redhat.com>
cc: pg smith <pete@linuxbox.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: LKM rootkits in 2.6.x
In-Reply-To: <20040311184835.GA21330@redhat.com>
Message-ID: <Pine.LNX.4.58.0403140141430.4421@twin.jikos.cz>
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk>
 <20040311184835.GA21330@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004, Dave Jones wrote:

>  > Any thoughts on the future of LKM rootkits in the 2.6 kernel branch ? In
>  > the last few years I've become quite interested in them (from a defensive
>  > point of view), but with the 2.6 kernel no longer exporting the syscall
>  > table, intercepting system calls would appear to be a non-starter now.
> Don't bet on it.  They'll just start doing what binary-only driver vendors
> have been doing for months.. If the table isn't exported, they find a symbol
> that is exported, and grovel around in memory near there until they find
> something that looks like it, and patch accordingly.

Why bother .. just find any symbol (function name) which is exported to
modules and also being frequently called somehow indirectly from userland
(VFS layer functions, vm functions, ...) and use this function as an
open-backdoor spell.

It is easy to patch existing rootkits this way.

-- 
JiKos.
