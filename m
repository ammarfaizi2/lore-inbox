Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUHDMPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUHDMPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUHDMPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:15:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264571AbUHDMPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:15:13 -0400
Date: Wed, 4 Aug 2004 08:14:56 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Liu Tao <liutao@safe-mail.net>
cc: arjanv@redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Add a writer prior lock methord for rwlock
In-Reply-To: <4110BA81.4030309@safe-mail.net>
Message-ID: <Pine.LNX.4.44.0408040814240.7628-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Liu Tao wrote:

> write_forcelock() should be used to avoid readers starve writers, or for
> writers to update shared data as far as possiable, since it prevents new
> readers acquire the lock while it's waiting for existing readers release
> their locks.

Looks like it should deadlock if you have multiple CPUs
trying to upgrade from a read lock to a write lock
simultaneously...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

