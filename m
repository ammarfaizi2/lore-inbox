Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVKUQX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVKUQX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVKUQX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:23:56 -0500
Received: from gscsmtp.wustl.edu ([128.252.233.26]:37078 "EHLO
	gscsmtp.wustl.edu") by vger.kernel.org with ESMTP id S932379AbVKUQXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:23:55 -0500
Message-ID: <4381F496.8040001@watson.wustl.edu>
Date: Mon, 21 Nov 2005 10:23:50 -0600
From: Richard Wohlstadter <rwohlsta@watson.wustl.edu>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question regarding sibling field in cpuinfo and hyperthreading enabled/disabled
 in bios
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've recently been told that the siblings field in /proc/cpuinfo should 
have a count of 2 when hyperthreading is enabled in the bios of a 
machine and should drop to 1 when hyperthreading is disabled in the bios 
of a machine.  I have a vendor who is using this algorithm to decide 
whether they should divide by 2 on the number of processors showing in 
/proc/cpuinfo to obtain the real count of physical processors in the 
machine.  I've noticed on my Dell 2-cpu Xeon, that siblings field does 
not change when you enable/disable the hyperthreading feature in the 
bios (only the number of processors seen in /proc/cpuinfo).  My question 
  I guess is this a bug in the bios of my Dell box(should siblings count 
drop to 1 when hyperthreading is disabled?).  I would think a better 
approach for the vendor would be to look at the physical ID field in 
/proc/cpuinfo since I've noticed that each real physical cpu has a 
different ID.

Please CC me on answers since I'm not on the list.  Thanks for any 
insight you provide.

Rich Wohlstadter
Genome Sequencing Center
Washington University of Saint Louis
rwohlsta@watson.wustl.edu
