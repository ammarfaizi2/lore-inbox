Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVAPCPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVAPCPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVAPCMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:12:34 -0500
Received: from [81.2.110.250] ([81.2.110.250]:7299 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262400AbVAPCEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:04:31 -0500
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: matthias@corelatus.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050115013013.1b3af366.akpm@osdl.org>
References: <16872.55357.771948.196757@antilipe.corelatus.se>
	 <20050115013013.1b3af366.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105830384.16028.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 00:58:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-15 at 09:30, Andrew Morton wrote:
> Matthias Lang <matthias@corelatus.se> wrote:
> These are things we probably cannot change now.  All three are arguably
> sensible behaviour and do satisfy the principle of least surprise.  So
> there may be apps out there which will break if we "fix" these things.
> 
> If the kernel version was 2.7.0 then well maybe...

These are things we should fix. They are bugs. Since there is no 2.7
plan pick a date to fix it. We should certainly error the overflow case
*now* because the behaviour is undefined/broken. The other cases I'm not
clear about. setitimer() is a library interface and it can do the basic
checking and error if it wants to be strictly posixly compliant.


