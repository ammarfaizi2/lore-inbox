Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbUKQQwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUKQQwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKQQuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:50:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62948 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262405AbUKQQpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:45:51 -0500
Subject: Re: Strange I/O errors for hard-disk driver with bad sectors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anton Lavrentiev <anton_lavrentiev@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041116162230.74768.qmail@web52302.mail.yahoo.com>
References: <20041116162230.74768.qmail@web52302.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100706158.419.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 15:42:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-16 at 16:22, Anton Lavrentiev wrote:
> Or, there are indeed few bad sectors in a row that kernel
> reports by using sector number of the first one, which it
> couldn't read?
> 
> I also used dd to skip to the sectors that it reported as
> unreadable, and read them one by one -- no success, but the
> kernel keeps reporting the same "magic" sector number for
> all these attempts:

Disk sectors in software and disk sectors in the magic internal world of
the disk are not neccessarily the same size so don't be suprised to lose
a bunch.

If you want to read exact sectors without readahead and other
complications
use O_DIRECT I/O

