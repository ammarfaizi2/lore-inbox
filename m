Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbTDJBXw (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 21:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTDJBXv (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 21:23:51 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:39566 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263978AbTDJBXt (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 21:23:49 -0400
Date: Thu, 10 Apr 2003 11:33:49 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Subject: 2.5->2.4 nfs corrupts
Message-ID: <20030410013349.GC467@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nfs server: 2.4.21-pre2
nfs client: 2.5.67

Every now and then I have problems copying data to and from the nfs
mount. It can either result in aborted writes like this:

15 [11:23:59] >> mv maestro.mpeg /share/funny                        
mv: closing `/share/funny/maestro.mpeg': Input/output error
15 [11:24:24] >> cp maestro.mpeg /share/funny

(it succeeded on the 2nd go)

or reads where unzip failed to unzip a file across the nfs link. there's
nothing in dmesg on either side of the fence to indicate problems and
while there was no message in the logs today, yesterday when I was
writing to the nfs server and got some corrupt files tyhis was logged:

messages:Apr  9 11:50:19 theirongiant kernel: nfs: server bob not responding, timed out
messages:Apr  9 13:15:29 theirongiant kernel: nfs: server bob not responding, timed out

But this is a local lan and the pc was never unplugged nor do problems
come up in anything else at any other time. The eepro driver didn't
detect a disconnection either.

Hope this helps. I'll do some more digging if someone can tell me what
to dig with and how. This is all I can think of atm.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
