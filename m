Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757261AbWKWBeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbWKWBeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757262AbWKWBeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:34:37 -0500
Received: from smtp-out.google.com ([216.239.45.12]:56243 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1757261AbWKWBeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:34:36 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=JJPExoOl5WDfJMhTDLWA9lydDpsgYPjEYB4SXFNUnFyfNvd5z0isrFuqSpHxOLfDT
	QQdWgZ9rImhdeFTdkC7pg==
Subject: [Patch0/4]: fake numa for x86_64 patches
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 22 Nov 2006 17:34:04 -0800
Message-Id: <1164245644.29844.146.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set resolves issues with running fake numa on x86_64.  We
have also extended the command line numa=fake=NUM command line option to
specify different size nodes.  The default NODES_SHIFT is also
incremented from 6 to 8 to allow MAX_NUM_NODES to be 256.

Patch [1/4]: Add the e820_hole_size to give the size of hole in a given
address range

Patch [2/4]: Increase the NODE_SHIFT from 6 to 8.

Patch [3/4]: Fix the existing numa=fake so that ioholes are
appropriately configured.  Currently machines that have sizeable IO
holes don't work with numa=fake>4.

Patch[4/4]: Extend the command line so that user can specify different
size nodes on a command line.

Signed-off-by: David Rientjes <reintjes@google.com>
Signed-off-by: Paul Menage <menage@google.com>
Signed-off-by: Rohit Seth <rohitseth@google.com>

