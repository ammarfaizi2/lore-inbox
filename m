Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWGMFXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWGMFXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWGMFXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:23:24 -0400
Received: from hera.kernel.org ([140.211.167.34]:5032 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751384AbWGMFXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:23:24 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
Date: Wed, 12 Jul 2006 22:23:12 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e94lc0$tsv$1@terminus.zytor.com>
References: <44B52674.8060802@suse.com> <20060712175542.108e6e37.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1152768192 30624 127.0.0.1 (13 Jul 2006 05:23:12 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 13 Jul 2006 05:23:12 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060712175542.108e6e37.akpm@osdl.org>
By author:    Andrew Morton <akpm@osdl.org>
In newsgroup: linux.dev.kernel
>
> On Wed, 12 Jul 2006 12:42:28 -0400
> Jeff Mahoney <jeffm@suse.com> wrote:
> 
> >  On systems with block devices containing slashes (virtual dasd, cciss,
> >  etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
> >  it being interpreted as a subdirectory. The generic block device code
> >  changes the / to ! for use in the sysfs tree. This patch uses that
> >  convention.
> 
> Isn't it a bit dumb of us to be putting slashes in the device names anyway?
>  It would be better, if poss, to alter dasd/cciss/etc and stop all these
> s@/@!@everywhere games.

A *lot* of people have been requesting more, not less, hierarchy in
the filenames in /dev, and by now there is plenty of history there,
too.  The convention needs to be consistent and stable, though.

	-hpa

