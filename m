Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWBMQul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWBMQul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWBMQuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:50:40 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56470 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932220AbWBMQuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:50:39 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43F0B887.5080308@s5r6.in-berlin.de>
Date: Mon, 13 Feb 2006 17:49:11 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: Arjan van de Ven <arjan@infradead.org>,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 2/4] firewire: dynamic cdev allocation below firewire	major
References: <1138919238.3621.12.camel@localhost>	 <1138920012.3621.19.camel@localhost>	 <20060213035150.GE3072@conscoop.ottawa.on.ca>	 <1139815941.2997.9.camel@laptopd505.fenrus.org> <1139832174.6388.31.camel@localhost>
In-Reply-To: <1139832174.6388.31.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.544) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> Seems pretty weird to effectively allocate 256 device numbers
> for just a single device, but ok :)
> I'll drop the patch and make it allocate a new major for every device
> plugged in.

Your driver could internally dispatch 256 minor device numbers after
it got itself its own dynamic major number. This should even be
acceptable as a hard limit of mem1394 devices. One would need quite a
lot of 1394 cards (or 1394.1 bridges) to get access to 256 FireWire
nodes at once.
-- 
Stefan Richter
-=====-=-==- --=- -==-=
http://arcgraph.de/sr/
