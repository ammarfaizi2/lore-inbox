Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUCRRsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUCRRsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:48:05 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:48354 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262813AbUCRRsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:48:00 -0500
Message-ID: <4059E0B2.4030601@nortelnetworks.com>
Date: Thu, 18 Mar 2004 12:47:30 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: sched_setaffinity usability -- other issue
References: <40595842.5070708@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a different issue with setting cpu affinity.  Has anyone 
considered a "soft" affinity?

I'm thinking of the case where I want to run processes on separate cpus 
for performance reasons, but in the case that one cpu becomes 
unavailable (physically removed, hardware fault, etc.) I would like to 
move those processes back to working cpus (except for maybe the one that 
was actually running and therefore might be corrupted).  In this case a 
reduced performance might be preferable to an unplanned failover to 
backup hardware.

Has this scenario been considered, or will cpu affinity be a "hard" setting.

Chris

