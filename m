Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUGSVZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUGSVZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 17:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUGSVZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 17:25:33 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:44449
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S264183AbUGSVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 17:25:32 -0400
Subject: Re: [PATCH] inotify 0.5
From: John McCutchan <ttb@tentacle.dhs.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Ian Kent <raven@themaw.net>, Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
In-Reply-To: <40FBCD8F.1080300@nortelnetworks.com>
References: <Pine.LNX.4.58.0407191642080.8909@wombat.indigo.net.au>
	 <40FBCD8F.1080300@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1090272690.6954.1.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Jul 2004 17:31:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-19 at 09:33, Chris Friesen wrote:
> Ian Kent wrote:
> 
> > So the number of watches is restricted to the max number of file
> > handles/process?
> 
> Note: I have not read the code.  We should probably do so before speculating.
> 
> However, it looks like you have one fd, and reading from it gives you a data 
> structure of information about the event.  The max number of watches could be as 
> high as INT_MAX depending on implementation.

Yes you are right. The maximum number of watchers is per-device. I have
it defined as 256 now. Also the maximum number of devices that can be
opened at a time is 8.

John
