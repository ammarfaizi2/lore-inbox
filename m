Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbUK3Tp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbUK3Tp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbUK3TpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:45:12 -0500
Received: from [213.146.154.40] ([213.146.154.40]:42977 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262277AbUK3Tn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:43:29 -0500
Date: Tue, 30 Nov 2004 19:43:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>,
       James Morris <jmorris@redhat.com>
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041130194328.GA28126@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wright <chrisw@osdl.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>,
	James Morris <jmorris@redhat.com>
References: <20041130095045.090de5ea.akpm@osdl.org> <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil> <20041130112903.C2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130112903.C2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 11:29:03AM -0800, Chris Wright wrote:
> My concerns are that the check has to be duplicated in any module,
> and that thus far we've tried to keep out fs -> module communication,
> letting vfs do it.  This could at least be fs -> vfs communication,
> and then either vfs or security framework could check flags and never
> call into module on fs private objects.

(1) an inode beeing private could have much more uses even outside LSM
(2) it's an awfull lot of code where having a flag is really little code
(3) there 's lots of room in the inode flags

I can't find anything that speaks for the messy current implementation

