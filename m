Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUEXPXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUEXPXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 11:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbUEXPXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 11:23:44 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:48116 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264305AbUEXPXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 11:23:42 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Timothy Miller" <theosib@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Linux stability despite unstable hardware
Date: Mon, 24 May 2004 10:10:19 -0500
X-Mailer: KMail [version 1.2]
Cc: miller@techsource.com
References: <BAY1-F135u0T4Dk5Je6000264da@hotmail.com>
In-Reply-To: <BAY1-F135u0T4Dk5Je6000264da@hotmail.com>
MIME-Version: 1.0
Message-Id: <04052410101900.02297@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2004 16:57, Timothy Miller wrote:
> I have had some issues recently with memory errors when using aggressive
> memory timings.  Although memory tests pass fine, gcc would tend to crash
> and would generate incorrect code when compiling other things. Gcc couldn't
> even build itself properly under those conditions.
>
> The really interesting thing is that the Linux kernel was totally
> unaffected.  Compiling the Linux kernel is often thought of as a stressful
> thing for a system, yet compiling a kernel with a broken gcc on a system
> with intermittent memory errors goes through error free, and the kernel is
> 100% stable when running.
>
> But until the memory errors were fixed, things like KDE wouldn't build
> without gcc crashing.
>
> So, what is it about Linux that makes it build properly with a broken GCC
> and run perfectly despite memory errors?

Been there, seen that too.

I think it has to do with smaller files. This reduces the memory pressure and
the power requirements of the overall system. Once the compiler gets loaded in
memory, it stayes there, small files (without too many includes) keep the
buffer requirements down, and reuses memory that may be better.

I fixed mine by just treating everything as the next lower grade memory 
(switched the BIOS from 60ns to 70ns). I didn't even see a significant
performance reduction either.
