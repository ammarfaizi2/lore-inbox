Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSKVSHy>; Fri, 22 Nov 2002 13:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSKVSHy>; Fri, 22 Nov 2002 13:07:54 -0500
Received: from mail.gmx.de ([213.165.65.60]:39321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265174AbSKVSHq>;
	Fri, 22 Nov 2002 13:07:46 -0500
Message-ID: <3DDE8332.7080909@gmx.net>
Date: Fri, 22 Nov 2002 20:19:14 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Pollard <pollard@admin.navo.hpc.mil>, linux-kernel@vger.kernel.org
Subject: Re: Failover in NFS
References: <Pine.LNX.3.96.1021121154055.10456C-100000@gatekeeper.tmr.com> <200211211652.53065.pollard@admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

>On Thursday 21 November 2002 02:58 pm, Bill Davidsen wrote:
>  
>
>>On Mon, 18 Nov 2002, Jesse Pollard wrote:
>>    
>>
>>>It would actually be better to use two floating IP numbers. That way
>>>during normal operation, both servers would be functioning simultaneously
>>>(based on the shared storage on two nodes).
>>>
>>>Then during failover, the floating IP of the failed node is activated on
>>>the remaining node (total of 3 IP numbers now, one real, two floating).
>>>The NFS recovery cycle should then cause the clients to remount the
>>>filesystem from the backup server.
>>>
>>>When the failed node is recovered, the active server should then disable
>>>the floating IP associated with the recovered server, causing only the
>>>mounts using that IP number to fall back to the proper node, balancing
>>>the load again.
>>>      
>>>
>>That works for stateless connections, but for stateful connections like
>>POP, NNTP, SMTP, etc, you will lose all the connections currently
>>actively.
>>    
>>
>
>yes. That is the point. NFS v3/4 CAN use TCP connections. The only way
>I know to force them back to the recovered server IS to kill the connection.
>
NFS over TCP does work very well for such failover configurations with a 
virtual IP address.

To the NFS client a failover is indistinguishable from a server 
crash+reboot which
is guaranteed to work by NFS standard definition.

