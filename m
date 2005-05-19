Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVESEbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVESEbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 00:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVESEbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 00:31:11 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:65466 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262465AbVESEbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 00:31:03 -0400
Date: Wed, 18 May 2005 21:30:49 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
Message-ID: <20050519043049.GH1340@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <8E7D9068-5392-4479-9207-18C63618A133@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8E7D9068-5392-4479-9207-18C63618A133@mac.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 10:30:56PM -0400, Kyle Moffett wrote:
> Does this include support for UNIX sockets and named pipes?
Unfortunately no, at least not on a clustered level. Local node, those
should work as normal. If you absolutely need this functionality, I believe
OpenSSI currently supports it.

If you're looking for an easy way to share small amounts data between
applications in an OCFS2 cluster, you might be interested in looking at
dlmfs. Once mounted, it's quite trivial to create dlm domains and lock
resources between nodes via regular file system operations (open, close,
etc). File read and write will return and set the resource LVB for you,
currently 64 bytes. Though this can all be controlled from shell, a small
library (libo2cb) to take advantage of this is provided in the current
toolchain distribution.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

