Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUGMFYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUGMFYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 01:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUGMFYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 01:24:16 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:48554 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264260AbUGMFYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 01:24:06 -0400
Date: Mon, 12 Jul 2004 22:24:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040713052402.GA28939@taniwha.stupidest.org>
References: <20040712225338.GD23623@taniwha.stupidest.org> <E1BkCLk-0000eo-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BkCLk-0000eo-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 03:44:52AM +0200, Bernd Eckenfels wrote:

> I can say, that nulls in files are most common at the end of
> (sys)log files filing up to the next block boundary.

Ideally syslog would rewind back past an nulls when it opens files.

> ls -s compared with ls -l should make that visible?

No, unwritten extents has an on-disk place, just the data isn't
written.  I'm not sure if there is an easy way to tell if an extent is
unritten or not, I guess you could use xfs_bmap -p if that's working
right for you.


  --cw

