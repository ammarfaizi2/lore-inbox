Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTIWRXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTIWRWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:22:46 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:12194 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262119AbTIWRWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:22:25 -0400
To: linux-kernel@vger.kernel.org
Subject: ICH5-SATA drivers freeze system when drives are spun down
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 23 Sep 2003 13:22:23 -0400
Message-ID: <87k77zqv1s.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've always used noflushd to spin down the drives I don't use much. Some of my
older drives are really noise, and there's enough heat in there as it is. I
just switched to a new system and I find on my new motherboard with a ICH5
SATA controller the system doesn't behave properly when the drives are spun
down.

The entire system freezes periodically for anywhere from half a second to 10s.
This happens about once a minute or so, sometimes more. During this time the
entire system is frozen, but when it recovers it processes all the lost i/o.

I also find when there is i/o that should cause a drive to wake up it takes
waay too long to wake up. It's as if the drive isn't even being woken up for
10-15s. Then I get dma timeouts in my logs.

Is it that the ICH5 controller is buggy and behaves poorly when drives are
powered off? Or is it the driver that isn't handling something properly? Does
anyone else use noflushd with the ICH5 driver?

-- 
greg

