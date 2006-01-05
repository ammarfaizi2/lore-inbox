Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWAENlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWAENlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAENlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:41:46 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:27351 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751221AbWAENlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:41:45 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs uninterruptable sleep
In-Reply-To: <87zmmbt1ce.fsf@hardknott.home.whinlatter.ukfsn.org> (Roger
	Leigh's message of "Thu, 05 Jan 2006 10:29:05 +0000")
References: <87zmmbt1ce.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Date: Thu, 05 Jan 2006 13:39:42 +0000
Message-ID: <87k6depzdt.fsf@hardknott.home.whinlatter.ukfsn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Leigh <rleigh@whinlatter.ukfsn.org> writes:

> Hi folks,
>
> I use a USB storage device (Kingston 128 MiB keydrive) to hold GPG
> keys, which is automounted with autofs4.  It's looking like a write
> operation on the device (so far always involving an ext2_delete_inode
> up to sync_buffer) causes the process to hang in an uninterruptable
> sleep.
>
> The system is running stock kernel.org linux-2.6.15 and 2.6.14.5 on a
> PowerPC 7447A system (Mac Mini) running Debian unstable.  The .config
> is here: http://www.whinlatter.ukfsn.org/config-2.6.15-hardknott.bz2

This does not appear to occur with 2.6.13.  On 2.6.15, it occurs only
when accessing the device through the autofs4 mount; it works
perfectly if mounted by hand.  This looks like it might be an autofs4
regression.


Regards,
Roger

-- 
Roger Leigh
                Printing on GNU/Linux?  http://gimp-print.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your mail.
