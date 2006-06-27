Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWF0Ol2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWF0Ol2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWF0Ol1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:41:27 -0400
Received: from testhaus.cns.utoronto.ca ([128.100.103.99]:34751 "EHLO
	testhaus.cns.utoronto.ca") by vger.kernel.org with ESMTP
	id S1030188AbWF0Ol0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:41:26 -0400
Subject: Re: [klibc] klibc and what's the next step?
From: Jeff Bailey <jbailey@ubuntu.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, torvalds@osdl.org, klibc@zytor.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
	 <Pine.LNX.4.64.0606271316220.17704@scrub.home>
Content-Type: text/plain; charset=utf-8
Date: Tue, 27 Jun 2006 15:40:50 +0100
Message-Id: <1151419250.5276.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 27 juin 2006 à 15:12 +0200, Roman Zippel a écrit :

> So anyone who likes to see klibc merged, because it will solve some kind 
> of problem for him, please speak up now. Without this information it's 
> hard to judge whether we're going to solve the right problems.

For Ubuntu, klibc could exist perfectly fine outside of the kernel -
We're using it already and have been for about a year now.

What merging will help us with is:

1) Making sure that klibc remains able to get the system running.  That
way some subtle mismatch between the kernel and klibc doesn't cause a
boot failure on a less-tested config.

2) Help us stay close to the best-practice for booting.  This is both
for making sure that people don't wind up with an unexpected experience
using Ubuntu, but also so that we can contribute back to the common
core.

3) Work towards removing the bootup pieces from the kernel that aren't
used anymore, reducing duplication, crufty in-kernel pieces, yada, yada,
yada...

I'd like to see klibc become the canonical way of booting the kernel
whether it's merged or not.  We already depend on outside tools to get
the system running (udev, module-init-tools), so adding klibc to this
doesn't seem that harmful.

Tks,
Jeff Bailey

