Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTLTIgM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 03:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTLTIgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 03:36:12 -0500
Received: from stinkfoot.org ([65.75.25.34]:15248 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S263857AbTLTIgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 03:36:10 -0500
Message-ID: <3FE3623D.9000706@stinkfoot.org>
Date: Fri, 19 Dec 2003 15:40:29 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: minor e1000 bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that the e1000 driver does not update the counters in
/proc/net/dev as quickly as several other drivers I've tried, such as
e100 (both the Becker driver, and Intel's), sk90lin, and 3c59x. These
drivers seem to update the counters in a very timely fashion while the
e1000 driver doesn't seem to update them for several seconds.  This is
apparent in 2.6.0, and 2.4.xx. Is there an update interval that might be
modified within the driver to fix this?  It screws up realtime bandwidth
measurements for these cards.


-Ethan

