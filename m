Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265373AbUEUEch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUEUEch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 00:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbUEUEch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 00:32:37 -0400
Received: from thunk.org ([140.239.227.29]:26518 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265373AbUEUEcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 00:32:33 -0400
Date: Fri, 21 May 2004 00:32:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: knobi@knobisoft.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm4: missing symbol __log_start_commit in ext3.o
Message-ID: <20040521043225.GA1334@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, knobi@knobisoft.de,
	linux-kernel@vger.kernel.org
References: <20040519151913.47070.qmail@web13906.mail.yahoo.com> <20040520001432.0f466182.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520001432.0f466182.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 12:14:32AM -0700, Andrew Morton wrote:
> 
> Ah, we forgot to export that symbol.
> 
> Actually that patch is being a bit naughty playing with JBD internals - it
> should be cast as a JBD entrypoint.

Yeah, good point; no point making ext3 and jbd more heavily incestuous
with each other.

> This isn't runtime-tested:

I've compiled and regression tested the patch, and it seems to work
just fine.

						- Ted
