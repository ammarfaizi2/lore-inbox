Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbTGBXeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265949AbTGBXeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:34:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21971 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265950AbTGBXd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:33:59 -0400
Message-ID: <3F036F3B.7030004@pobox.com>
Date: Wed, 02 Jul 2003 19:48:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Greg KH <greg@kroah.com>
Subject: inode/dcache overhead of sysfs attribute files?
References: <20030702215847.GA9973@kroah.com>
In-Reply-To: <20030702215847.GA9973@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody looked into the inode and dcache overhead of all this stuff, 
which I assume is pinned into memory a la ramfs?

I wonder if sysfs attributes could be accessed via the extended 
attribute VFS API?  A file full of EA's can easily be considered a 
key-value database, or attribute-value in this case :)  The EA names and 
values need not pin a bunch of inodes and dcache entries, either.
(though viro may scream at my mention of EAs :))

	Jeff



