Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268671AbTCCR5p>; Mon, 3 Mar 2003 12:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268620AbTCCR5p>; Mon, 3 Mar 2003 12:57:45 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:12765 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265736AbTCCR5n>; Mon, 3 Mar 2003 12:57:43 -0500
Message-ID: <3E6399F1.10303@nortelnetworks.com>
Date: Mon, 03 Mar 2003 13:07:45 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: terje.eggestad@scali.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: anyone ever done multicast AF_UNIX sockets?
References: <3E5E7081.6020704@nortelnetworks.com>	<1046695876.7731.78.camel@pc-16.office.scali.no>	<3E638C51.2000904@nortelnetworks.com> <20030303.085504.105424448.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Chris Friesen <cfriesen@nortelnetworks.com>
>    Date: Mon, 03 Mar 2003 12:09:37 -0500
> 
>    Unless you poll for messages on the receiving side, how do you trigger 
>    the receiver to look for a message?
> 
> Send signals.  Use a FUTEX, be creative...

Suppose I have a process that waits on UDP packets, the unified local 
IPC that we're discussing, other unix sockets, and stdin.  It's awfully 
nice if the local IPC can be handled using the same select/poll 
mechanism as all the other messaging.


Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

