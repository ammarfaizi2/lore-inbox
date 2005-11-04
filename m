Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030594AbVKDDuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030594AbVKDDuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbVKDDuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:50:02 -0500
Received: from mail.dvmed.net ([216.237.124.58]:23989 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030595AbVKDDuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:50:01 -0500
Message-ID: <436ADA63.1090605@pobox.com>
Date: Thu, 03 Nov 2005 22:49:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Parallel ATA with libata status with the patches I'm working
 on
References: <1131029686.18848.48.camel@localhost.localdomain>
In-Reply-To: <1131029686.18848.48.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My general take on things:

* Supporting PATA has always been a long term libata goal (and people 
have known this for years).

* I try to stay as far as possible away from the fight between Alan and 
Bart.  As the changelog shows, I've merged libata patches from both.

* Alan's patches do tend to come straight to me, and it would be nice if 
he CC'd them to a list (linux-ide).

* Nonetheless, they get exposure in -mm (via libata-dev.git) for a 
while, before going upstream.

* The non-core changes, i.e. Alan and Albert's PATA drivers, aren't 
going upstream for a while, and will be instead living in -mm (via my 
"pata-drivers" libata-dev.git branch)  Too much breakage and user 
confusion will occur if they are pushed {today|soon}.

* CONFIG_IDE=n is still largely for developers and brave souls only (or 
for lucky owners of the newest boxes, which simply don't have PATA on 
them at all).


