Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUECMH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUECMH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUECMH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:07:28 -0400
Received: from firewall.conet.cz ([213.175.54.250]:62930 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S263641AbUECMH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:07:27 -0400
Date: Mon, 3 May 2004 14:07:25 +0200
From: root <libor@conet.cz>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading from file in module fails
Message-ID: <20040503120725.GA27213@Loki>
References: <20040503105041.GA12023@Loki> <20040503113500.GB31513@harddisk-recovery.com> <20040503114316.GA22732@Loki> <20040503114859.GC31513@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503114859.GC31513@harddisk-recovery.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 01:48:59PM +0200, Erik Mouw wrote:
> On Mon, May 03, 2004 at 01:43:16PM +0200, Libor Vanek wrote:
> > > (BTW, if you need to copy files from kernel, it's usually a sign of bad
> > > design)
> > It's not bad design - what I'm doing is writing snapshots for VFS as
> > my diploma thesis. And I need to create copy of file before it's
> > changed (copy-on-write). There is no other way how to do it in
> > kernel-space (and user-space solutions like using LUFS are really
> > slow)
> Have a look at the cowlinks (copy-on-write links) thread from last
> month, it might do the trick.

Hmmm, that seems to have several serious disadvantages:
- it's not filesystem/user-space SW independent (requires modifying them - as far as I understand how it's done)
- needs to "touch" all existing files/dirs (maybe I'm wrong but from very first look it seems to me that I need to setup "cow" flag on each file/dir I want to "cow") - my approach should be "atomic" even when I need to setup snapshot on directory containing 100s thousands of files/dirs (and that's an average server I'm thinking of!)

Nevertheless - thanks for a tip.

Libor
