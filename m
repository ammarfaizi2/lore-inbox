Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWHYXwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWHYXwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHYXwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:52:40 -0400
Received: from mga06.intel.com ([134.134.136.21]:48781 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932236AbWHYXwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:52:39 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="115147048:sNHT25361581"
Message-Id: <20060825235215.820563000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 16:52:15 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Akkana Peck <akkana@shallowsky.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Chris Wedgewood <cw@foof.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Adrian Bunk <bunk@stusta.de>
Subject: [patch 0/1] Relative atime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was enough interest in the relative atime patches that I went
ahead and implemented support in the mount command as well, and
cleaned up the patches for inclusion.  Relative atime only updates the
atime if the previous atime is older than the mtime or ctime.  It's
like noatime, but useful for applications like mutt that need to know
whether a file has been read since it was last modified.

-VAL
