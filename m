Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUIQAie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUIQAie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 20:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUIQAi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 20:38:29 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:49097 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268464AbUIQAiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 20:38:24 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@novell.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095376979.23385.176.camel@betsy.boston.ximian.com>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
	 <1095376979.23385.176.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095377752.23913.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 00:35:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-17 at 00:22, Robert Love wrote:
> The thing you are missing is that you absolutely have to pin something
> or you have multiple VFS races.  Your bitmap suggestion, while cute,
> really shows a lack of understanding of the problem space.

How many of the races matter. There seem to be several different
problems here and mixing them up might be a mistake. 

1.	I absolutely need to get the right file at the right moment, please
mass me a descriptor to the file as the user closes it so I always get
it right (indexer, virus checker)

2.	If something happens bug me and I'll have a look (eg file manager)

Also it varies between "This file" and "everything in this subtree".
An indexer for example really wants to know "this file, this path" for
entire subtrees and to index the right object (if the path changes thats
less of an issue). 

Alan

