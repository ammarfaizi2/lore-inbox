Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRDHNdr>; Sun, 8 Apr 2001 09:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132559AbRDHNdh>; Sun, 8 Apr 2001 09:33:37 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132561AbRDHNdZ>;
	Sun, 8 Apr 2001 09:33:25 -0400
Message-ID: <20010408152241.A121@bug.ucw.cz>
Date: Sun, 8 Apr 2001 15:22:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: seasons@falcon.sch.bme.hu
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp & 2.4.3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found it works if I disable "save/restore of hw state".

I still need to restart driver of my psaux mouse.

								Pavel
PS: BTW you should talk to acpi maintainers: acpi requires _os_ to do
this kind of stuff.

PPS: You should warn about logging filesystems. Using swsusp on
reiserfs could lead to pretty bad things: mounting of reiserfs (even
readonly!) means log is replayed, which means writes to
filesystem. That could lead to pretty bad corruption.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
