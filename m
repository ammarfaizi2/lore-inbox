Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWKGTMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWKGTMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbWKGTMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:12:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:13460 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752041AbWKGTMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:12:49 -0500
X-Authenticated: #283898
Message-ID: <4550DABA.40600@gmx.net>
Date: Tue, 07 Nov 2006 20:12:58 +0100
From: Tobias Pflug <tobias.pflug@gmx.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fs indexing/ querying on meta-data
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

At university I am currently dealing with file indexing/query features
as they exist in the BeFS or SkyFS. In BeFS you could commit a query like:

(name == "*.c" || name == "*.h" ) && size > 20000

API functions were available to commit such queries which would use some 
attribute b-tree to find matching files.

Now to get to the point: I would like to implement such functionality on 
a very basic level (Only very simple queries) for a fs in the linux 
kernel. I thought of parsing files in userland, extracting any usable 
meta-data (such as id3 tags) and storing them as extended attributes of 
the respective
files.

My problem is that I am not sure on which approach I should take on 
this. Should I attempt to hack such functionality into an existing fs ? 
If so, which one would be suited best? Maybe the much discussed 
reiser4-plugin-interface could actually be useful for this one?

I also considered using FiST (http://www.am-utils.org/project-fist.html, 
stackable filesystem language)
but the development seems to be stalled, I am having issues with 
compilation, the author doesn't respond
and I read about people having major issues with it (segfaults etc..)

Finally there is the option of using FUSE, but I have to admit I haven't 
had a closer look at it yet.

I hope this posting isn't so clueless&chaotic that people can't be 
bothered to answer :) I'd be thankful
for any word of advice and/or pointers on this topic.

regards,
Tobi

PS: please CC to tobias.pflug@gmx.net , I am not subscribed to lkml. 
Thank you!
