Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTH2M5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 08:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbTH2M5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 08:57:54 -0400
Received: from shark.pro-futura.com ([161.58.178.219]:30910 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261176AbTH2M5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 08:57:50 -0400
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
To: linux-kernel@vger.kernel.org
Subject: Pagecache going out of control (2.4)
Date: Fri, 29 Aug 2003 14:59:10 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308291459.10983.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

For some time now, the situation with 2.4 kernels is the following: Try to 
gzip -d very large file (few times larger than physical RAM) in the 
background and do some other work. You will find out that your system gets 
very slow. All RAM is used up for pagecache, and even more, your application 
data is getting swapped out to make more room for pagecache!

I think this is a bad behaviour, and would pretty much like to be able to 
control the maximum memory used for pagecache.

Recently, I found a patch by indou.takao@jp.fujitsu.com which implements a 
pgcache-max sysctl for 2.5.x. I tried to backport it to 2.4.21 but so far 
with no success (many differences in VM system).

I don't understand why not to give such a option to users, I know a lot of 
them irritated with current pagecache behaviour... options and 
configurability should be a good thing, no?

Best regards,
Tvrtko A. Ursulin

