Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTDKQzH (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTDKQzH (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:55:07 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:4249 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261287AbTDKQzF (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:55:05 -0400
Date: Sat, 12 Apr 2003 03:06:56 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: ext3 weirdness
Message-ID: <20030411170655.GA10449@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why would this:

while true; do dd if=/dev/zero of=foo count=100 bs=10000; rm foo; done

Produce the following result?

...
100+0 records in
100+0 records out
100+0 records in
100+0 records out
dd: writing `foo': No space left on device
70+0 records in
69+0 records out
dd: writing `foo': No space left on device
1+0 records in
0+0 records out
dd: writing `foo': No space left on device
1+0 records in
0+0 records out
dd: writing `foo': No space left on device
1+0 records in
0+0 records out
dd: writing `foo': No space left on device
1+0 records in
0+0 records out
...
dd: writing `foo': No space left on device
1+0 records in
0+0 records out
dd: writing `foo': No space left on device
1+0 records in
0+0 records out
dd: writing `foo': No space left on device
1+0 records in
0+0 records out
100+0 records in
100+0 records out
100+0 records in
100+0 records out
...


-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
