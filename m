Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUARRzq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 12:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUARRzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 12:55:46 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:16065 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262123AbUARRzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 12:55:45 -0500
Date: Sun, 18 Jan 2004 09:55:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg Fitzgerald <gregf@bigtimegeeks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slowwwwwwwwwwww NFS read performance....
Message-ID: <20040118175534.GC1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Greg Fitzgerald <gregf@bigtimegeeks.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange> <200401130155.32894.hackeron@dsl.pipex.com> <1074025508.1987.10.camel@lumiere> <1074026758.4524.65.camel@nidelv.trondhjem.org> <bu4pd6$anf$1@news.cistron.nl> <1074134135.1522.52.camel@nidelv.trondhjem.org> <1074193256.2148.55.camel@nidelv.trondhjem.org> <20040118060404.GA20769@evilbint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118060404.GA20769@evilbint>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 01:04:04AM -0500, Greg Fitzgerald wrote:
> Ever since i upgraded to 2.6 my NFS performance has dropped.
> I have a OpenBSD Server running nfsd. The other boxes on my lan
> running windows and or the 2.4.x kernel have no performance problems.
> Files transfer at normal speeds for a 100mbit connection. My main workstation
> which is running 2.6.1-mm4 (i have also had 2.6.1 and 2.6.0 on it) has 
> almost zero nfs performance. I get at the most 500K/s. Anyone have ideas?
> I upgraded to -mm4 having seen some NFS fixes in the patch but none of them
> seem to have applied to my situation. Thanks in advance.

Are you using nfsd on 2.6 too?

check /proc/mounts for what your wsize and rsize are for the nfs mounts, and
lower it and see if that helps, 2.4 uses 8192.

Try tcp-nfs also.
