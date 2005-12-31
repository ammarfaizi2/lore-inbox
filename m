Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVLaArs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVLaArs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLaArs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:47:48 -0500
Received: from [81.2.110.250] ([81.2.110.250]:64129 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750853AbVLaArr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:47:47 -0500
Subject: Re: RAID controller safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051230185840.52264.qmail@web34113.mail.mud.yahoo.com>
References: <20051230185840.52264.qmail@web34113.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 31 Dec 2005 00:49:39 +0000
Message-Id: <1135990179.28365.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-30 at 10:58 -0800, Kenny Simpson wrote:
> So all writes would be treated as syncronous in the write-through case (no battery), making fsync
> a no-op?

fsync is never a no-op. fsync ensures material the OS is caching hits
disk drivers/disks. Barriers or write through on the disk driver ensure
that it hits the media.

The two are independant

