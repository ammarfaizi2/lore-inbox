Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWB1F0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWB1F0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWB1F0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:26:08 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:2210 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750830AbWB1F0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:26:07 -0500
Date: Tue, 28 Feb 2006 06:26:06 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [RFC] vfs: cleanup of permission()
Message-ID: <20060228052606.GA6494@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Christoph! Al!

after thinking some time about the oracle words
(sent in reply to previous BME submissions) we 
(Sam and I) came to the conclusion that it would 
be a good idea to remove the nameidata introduced
in September 2003 from the inode permission()
checks, so that vfs_permission() can take care
of them ...

this is in two parts, the first one does the 
removal and the second one fixes up nfs and fuse
by passing the relevant nd_flags via the mask

Note: this is just a suggestion, so please let
      us know what you think 

