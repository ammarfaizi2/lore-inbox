Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTLWQs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTLWQs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:48:28 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:46231 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S261929AbTLWQs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:48:27 -0500
Date: Tue, 23 Dec 2003 17:46:57 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
In-Reply-To: <20031223163245.GA23184@suse.de>
Message-ID: <Pine.LNX.4.44.0312231740590.1079-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Jens Axboe wrote:

>> Since the atapi-mo patch is mine, is there something I need to do?
> Nah don't worry about it, Andrew and I just agreed that I'd merge the
> remaining changes once 2.6.0-mm1 was up. Basically, MO needs to set
> _RAM capability so we can kill the various MO checks.

Please remember that you can't send the MO drive any DVD-RAM specific
commands and expect it to work. The special-casing in the probe routine
in ide-cd is there for a reason, and I don't think calling
cdrom_dvdram_open_write would be a good idea, either. I haven't actually
looked at that routine, but if it sends anything to the drive, my MO
drive won't like it one bit. It will at best error out and then
cdrom_dvdram_open_write will error out, too, disallowing opening for
write, right?

-- 
Ciao,
Pascal

