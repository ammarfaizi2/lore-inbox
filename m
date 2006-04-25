Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWDYKsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWDYKsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWDYKsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:48:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33675 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932188AbWDYKsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:48:19 -0400
Subject: Re: Bug while executing : cat /proc/iomem on 2.6.17-rc1/rc2
From: Arjan van de Ven <arjan@infradead.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <444DFD53.2000108@in.ibm.com>
References: <444DFD53.2000108@in.ibm.com>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 12:48:16 +0200
Message-Id: <1145962096.3114.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 16:13 +0530, Sachin Sant wrote:
> I found this following problem while executing cat/proc/iomem. The 
> command causes following BUG.
> 
> x236:/linux-2.6.17-rc1/fs # cat /proc/iomem
> Segmentation fault


this tends to be a driver bug; could you compile all the drivers you
need as module, and then try to not load them as much as possible. See
if it still crashes, if not, load the rest one at a time until it
crashes, and then you've found the culprit :)


