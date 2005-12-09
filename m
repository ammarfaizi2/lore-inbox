Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVLIKAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVLIKAt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVLIKAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:00:49 -0500
Received: from tim.rpsys.net ([194.106.48.114]:32920 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751303AbVLIKAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:00:49 -0500
Subject: Re: Sluggish machine under 2.6.14 and 2.6.15-rc5
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1133978786.8096.52.camel@localhost.localdomain>
References: <1133978786.8096.52.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 10:00:41 +0000
Message-Id: <1134122442.8092.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 18:06 +0000, Richard Purdie wrote:
> ip8212 ide ports). I therefore installed 2.6.15-rc5 which ran badly and
> made the machine slow and sluggish. 2.6.14 shows the same speed issue.
> 2.6.13 runs just as well as 2.6.12 does. 

The issue was configuration. Somehow my use of make oldconfig had set a
number of debug options which started out unset. The spinlock changes of
2.6.13-git11 must have changed the overhead of spinlock debugging which
was the cause of the the slowdown I saw when comparing versions.

2.6.15-rc5 runs fine now.

Richard

