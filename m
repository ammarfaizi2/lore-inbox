Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSJPTpX>; Wed, 16 Oct 2002 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJPTpX>; Wed, 16 Oct 2002 15:45:23 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:40657 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261367AbSJPTpW>; Wed, 16 Oct 2002 15:45:22 -0400
Message-ID: <3DADC5F8.60708@kegel.com>
Date: Wed, 16 Oct 2002 13:03:04 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: John Gardiner Myers <jgmyers@netscape.com>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <Pine.LNX.4.44.0210151403370.1554-100000@blue1.dev.mcafeelabs.com> <3DAC9035.2010208@netscape.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
>>     while (read() == EAGAIN)
>>         wait(POLLIN);
>>
> Assuming registration of interest is inside wait(), this has a race.  If 
> the file becomes readable between the time that read() returns and the 
> time that wait() can register interest, the connection will hang.

Shouldn't the should be rearmed inside read() when it returns EAGAIN?
That's how I do it in my wrapper library these days.
No reason to have a race.

- Dan

