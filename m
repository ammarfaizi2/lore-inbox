Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUCKWMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUCKWMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:12:34 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60607 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261774AbUCKWMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:12:32 -0500
Message-ID: <4050E402.30505@nortelnetworks.com>
Date: Thu, 11 Mar 2004 17:11:14 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Joe Thornber <thornber@redhat.com>, Andi Kleen <ak@muc.de>,
       Mickael Marchand <marchand@kde.org>, linux-kernel@vger.kernel.org,
       dm@uk.sistina.com
Subject: Re: 2.6.4-mm1
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de> <20040311214354.GM18345@reti> <20040311215955.GC18020@ca-server1.us.oracle.com>
In-Reply-To: <20040311215955.GC18020@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Thu, Mar 11, 2004 at 09:43:54PM +0000, Joe Thornber wrote:
> 
>>struct dm_ioctl {			0
>>        uint32_t version[3];		
>>        uint32_t data_size;  		4
>>
>>        uint32_t data_start;
>>
>>        uint32_t target_count;
>>        int32_t open_count;
>>        uint32_t flags;		8
>>        uint32_t event_nr;
>>        uint32_t padding;		10 ***
> 
> 
> 	Here's probably the problem.  Many 64bit arches align 64bit
> numbers on a 64bit boundary.  So it is adding 2 more words of padding to
> start the u64 at offset 12.

But wouldn't this be applied across the board and therefore still work? 
  Or is it defined as "packed" somewhere?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
