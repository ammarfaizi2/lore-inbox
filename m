Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265850AbTIERrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbTIERrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:47:06 -0400
Received: from ida.rowland.org ([192.131.102.52]:3076 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265850AbTIERqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:46:36 -0400
Date: Fri, 5 Sep 2003 13:46:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: linux-kernel@vger.kernel.org
Subject: How can I force a read to hit the disk?
Message-ID: <Pine.LNX.4.44L0.0309051331230.678-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My kernel module for Linux-2.6 needs to be able to verify that the media 
on which a file resides actually is readable.  How can I do that?

It would certainly suffice to use the normal VFS read routines, if there
was some way to force the system to actually read from the device rather
than just returning data already in the cache.  So I guess it would be 
enough to perform an fdatasync for the file and then invalidate the file's 
cache entries.  How does one invalidate a file's cache entries?  Does 
filemap_flush() perform both these operations for you?

TIA,

Alan Stern

