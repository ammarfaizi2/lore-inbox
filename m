Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVCXUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVCXUBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVCXUBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:01:15 -0500
Received: from hera.kernel.org ([209.128.68.125]:42958 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261489AbVCXUBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:01:11 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Squashfs without ./..
Date: Thu, 24 Mar 2005 19:59:49 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d1v67l$4dv$1@terminus.zytor.com>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be> <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1111694389 4544 127.0.0.1 (24 Mar 2005 19:59:49 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 24 Mar 2005 19:59:49 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>
By author:    Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
In newsgroup: linux.dev.kernel
> 
> Then it is broken in several ways.  
> 
> First, file systems are not required to implement ".." (only "." is
> magical, ".." is a courtesy).  
> 

Sez who?  Realistically, most programs that display a list of
filenames and has "up one level" as part of the list (not all of them
do it that way) probably expect to get ".." in there to display this.

> Second, skipping the first two entries carries an implied assumtion
> about the file name sorting order that is not portable in a
> non-US-ASCII world.

Doesn't have anything to do with sorting order or US-ASCII, it has to
do with readdir order.  If nothing else, it would be highly surprising
if "." and ".." weren't first; it's certainly a de facto standard, if
not de jure.

	-hpa
