Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTE1Ipz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbTE1Ipz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:45:55 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:61724 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264619AbTE1Ipx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:45:53 -0400
Date: Wed, 28 May 2003 01:59:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69] ext3 error: rec_len %% 4 != 0
Message-Id: <20030528015920.0023121b.akpm@digeo.com>
In-Reply-To: <87ptm38nff.fsf@deneb.enyo.de>
References: <8765nva43w.fsf@deneb.enyo.de>
	<20030528012512.5d631827.akpm@digeo.com>
	<87ptm38nff.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 08:59:08.0764 (UTC) FILETIME=[664229C0:01C324F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
>
> > Falling back to ext2 for a while would be interesting.
> 
>  Okay, will fallback to ext2 next time a reboot is required.  (I guess
>  removing the has_journal feature using tune2fs is the easiest way to
>  do this, after a clean unmount, of course.)

No, just change its type to ext2 in /etc/fstab.

If it is the root filesystem, reboot with "rootfstype=ext2" on the
kernel command line and it will do what you want.

Make sure it's a clean shutdown though - ext2 will not mount a
needs-recovery ext3 filesystem.
 
