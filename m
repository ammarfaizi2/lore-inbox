Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131812AbRCOUOe>; Thu, 15 Mar 2001 15:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131813AbRCOUOY>; Thu, 15 Mar 2001 15:14:24 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:56685 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131812AbRCOUOS>; Thu, 15 Mar 2001 15:14:18 -0500
Message-ID: <3AB12209.5C2BD495@sgi.com>
Date: Thu, 15 Mar 2001 12:11:53 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <Pine.LNX.4.33.0103152344260.1320-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The not reclaiming swap space is flawed in more than once instance.
Suppose my P1 and P2 have their swap reserved -- now both grow.
P3 is idle but can't fit in swap.  This is going to result in fragmentation
no?  How is this fragmentation less worse than just freeing swap.

Ever since Ram sizes got to about 256M, I've tended toward using swap spaces 
about half my RAM size -- thinking of swap as an 'overflow' place that
really shouldn't get used much if at all.  As you mention, not reclaiming
swap space, but having 'double-reservations' for previously swapped
programs becomes a problem fast in this situation.  Makes the swap
much less flexible.

-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
