Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUEFRm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUEFRm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEFRm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:42:27 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:21351 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261706AbUEFRmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:42:20 -0400
Date: Thu, 6 May 2004 19:48:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, 4Front Technologies <dev@opensound.com>,
       Hannu Savolainen <hannu@opensound.com>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: What is needed to build an external module
Message-ID: <20040506174813.GA2387@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	4Front Technologies <dev@opensound.com>,
	Hannu Savolainen <hannu@opensound.com>,
	Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a private mail Dev Mazumdar suggested to create a system for 
building external modules without the necessity to have the
full kernel source available.

I decided to take this to LKML since it may be a questions
other people had.

The reason why one must use the kbuild infrastructure when 
building external modules are the CONFIG choices that either
impact gcc options or the include files.
If a seperate system for buiding modules were made that
part should be copied over for each and every change, and only
one particular version of the 'building external modules' would
be compatible with a given kernel version. So having a 
seperate system is a no-go.

What one should realize what is actually needed to build an
external module.
A full copy of:
root of kernel src
include/
scripts/
and a copy of the Makefile for the selected architecture.
Thats all needed to build a well behaving external module.
This could very well be what a distribution places in
/lib/modules/linux-<version>/build
and not a full kernel tree.

Hope this clarifies,

	Sam
