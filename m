Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWBNUkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWBNUkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBNUkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:40:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48618 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932335AbWBNUka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:40:30 -0500
Date: Tue, 14 Feb 2006 20:40:24 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add cast to __iomem pointer in scsi drivers
Message-ID: <20060214204024.GE27946@ftp.linux.org.uk>
References: <s5hzmktaecj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzmktaecj.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 09:13:16PM +0100, Takashi Iwai wrote:
> Add the missing cast to __iomem pointer in some scsi drivers.

NAK.  Don't add casts just to make gcc and/or sparse to STFU.  In particular,
sata side of that had been beaten to death many times over - see archives.
