Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVDDX5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVDDX5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDDXyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:54:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14978 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261492AbVDDXyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:54:13 -0400
Date: Tue, 5 Apr 2005 00:54:12 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc2
Message-ID: <20050404235412.GB8859@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org> <20050405093718.7f40ee3d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405093718.7f40ee3d.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:37:18AM +1000, Stephen Rothwell wrote:
> On Mon, 4 Apr 2005 14:32:52 -0700 (PDT) Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >   o missing include in lanai.c
> 
> After this patch I have ended up with linux/dma-mapping.h included twice
> in this file ...

Argh.  Looks like the same fix went in twice (now and in -rc1-bk3) and
these patches added include in places just far enough from each other to
create no rejects when porting patchset to -bk3 and further.
