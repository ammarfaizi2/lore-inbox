Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbUABQA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUABQA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:00:26 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48398 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265536AbUABQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:00:25 -0500
Date: Fri, 2 Jan 2004 16:00:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Libor Vanek <libor@conet.cz>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102160020.A24026@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Libor Vanek <libor@conet.cz>, Muli Ben-Yehuda <mulix@mulix.org>,
	linux-kernel@vger.kernel.org
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF59073.3060305@conet.cz>; from libor@conet.cz on Fri, Jan 02, 2004 at 04:38:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 04:38:27PM +0100, Libor Vanek wrote:
> I'm working on my diploma thesis which is adding snapshot capability 
> into Linux VFS (so you can do directory based snapshots - not complete 
> device, like in LVM). It'll consist of two separete modules:
> Snapshot module:
> - will hijack (one or another way) calls to open/move/unlink/mkdir/etc. 
> syscall
> - when will detect change to selected directory (which I want to 
> snapshot), it'll copy/move old file/directory to some temporary 
> (selected when creating snapshot) - in fact - copy on write behaviour

This should be implemented as a stackable filesystem..

