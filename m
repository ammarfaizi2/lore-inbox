Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUAEDOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265868AbUAEDOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:14:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265224AbUAEDOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:14:36 -0500
Date: Mon, 5 Jan 2004 03:14:35 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeremy Maitin-Shepard <jbms@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: st_dev:st_ino
Message-ID: <20040105031434.GB4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <200401042335.i04NZqQZ029910@turing-police.cc.vt.edu> <87k747w4ow.fsf@jbms.ath.cx> <20040105014755.GB24410@mark.mielke.cc> <87llontap1.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llontap1.fsf@jbms.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 09:02:02PM -0500, Jeremy Maitin-Shepard wrote:
 
> In order to efficiently implement tar, it is necessary to store the
> inode numbers for files with a link count greater than 1 in a hash
> table.  It would not be practical to keep open all of these files in
> order to ensure that the inode numbers remain valid.  Thus, a different
> unique identifier is needed, which is unique even for files that are not
> open.

Files that are not open could've been removed and replaced with something
completely different since your stat(2).
