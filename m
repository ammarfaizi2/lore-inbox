Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWGRN56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWGRN56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGRN56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:57:58 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:45200 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932218AbWGRN54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:57:56 -0400
Date: Tue, 18 Jul 2006 15:27:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Mandy Kirkconnell <alkirkco@sgi.com>, Nathan Scott <nathans@sgi.com>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 01/45] XFS: corruption fix
In-Reply-To: <20060717162518.GB4829@kroah.com>
Message-ID: <Pine.LNX.4.61.0607181526320.9156@yvahk01.tjqt.qr>
References: <20060717160652.408007000@blue.kroah.org> <20060717162518.GB4829@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Fix nused counter.  It's currently getting set to -1 rather than getting
>decremented by 1.  Since nused never reaches 0, the "if (!free->hdr.nused)"
>check in xfs_dir2_leafn_remove() fails every time and xfs_dir2_shrink_inode()
>doesn't get called when it should.  This causes extra blocks to be left on
>an empty directory and the directory in unable to be converted back to
>inline extent mode.
>
Is there a utility to fix such directories or will they autoshrink once the fs
is run with a 2.6.17.7?



Jan Engelhardt
-- 
