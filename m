Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVINAS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVINAS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVINAS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:18:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:16838 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964877AbVINAS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:18:27 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43276C2D.2000901@s5r6.in-berlin.de>
Date: Wed, 14 Sep 2005 02:17:49 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: Jan De Luyck <lkml@kcore.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: ACPI S3 and ieee1394 don't get along
References: <200509131156.31914.lkml@kcore.org>
In-Reply-To: <200509131156.31914.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.534) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
> after putting my laptop into S3 and reviving it at home, the firewire
> interface was unusable, no response when plugging in my external disk,
> loading sbp2 manually didn't trigger anything.
[...]
> I saw this thread:
> http://marc.theaimsgroup.com/?l=linux1394-user&m=111262313930798&w=2
> tho I'm not sure if it's relevant to this.

IEEE 1394 power management (i.e. management of bus power consumption or 
of other nodes' internal power states) is not related to ACPI suspend/ 
resume of the local controller AFAICS.

According to your log, the cause is to be looked for in ohci1394's 
purely hardware related parts or perhaps even outside of the ieee1394 
subsystem.
-- 
Stefan Richter
-=====-=-=-= =--= -===-
http://arcgraph.de/sr/
