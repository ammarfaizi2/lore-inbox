Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUFJBDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUFJBDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUFJBDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:03:10 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:63203 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S266081AbUFJBDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:03:06 -0400
Subject: Re: 2.6 vm/elevator loading down disks where 2.4 does not
From: Ray Lee <ray-lk@madrabbit.org>
To: Clint Byrum <cbyrum@spamaps.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2c0942db04060917542cb15077@mail.gmail.com>
References: <1086724300.5467.161.camel@localhost>
	 <2c0942db04060917542cb15077@mail.gmail.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1086829384.13085.10.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 18:03:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Upon investigation, we saw that the 2.6 box was reading from the disk
> about 5 times as much as 2.4.

I don't think this will account for the entire change in disk activity,
but 2.6.7-pre? contains a fix for the read ahead code to prevent it from
reading extra sectors when unneeded.

The fix applies to 'seeky database type loads' which...

> The data access patterns are generally "search through index files in
> a tree-walking type of manner, then seek to data records in data
> files."

...sounds like it may apply to you.

So, if you and your server have some time, you might try 2.6.7rc3 and
see if it changes any of the numbers.

Ray Lee

