Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263934AbTHVQ42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbTHVQ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:56:28 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:11713 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263934AbTHVQyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:54:47 -0400
Message-ID: <3F464A3E.2050203@nortelnetworks.com>
Date: Fri, 22 Aug 2003 12:52:14 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: help???  trying to trace code path of outgoing udp packet
References: <3F46356A.804@nortelnetworks.com> <3F46386A.4080009@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi wrote:
> Chris Friesen wrote:
> 
>> ip_finish_output     ip_output.c
>> ip_finish_output2    ip_output.c   dst->neighbour->output
> 
> 
> |
> V
> dev_queue_xmit()
> qdisc_run()
> qdisc_restart()
> dev->hard_start_xmit() [driver xmit routine]
> 
> this is for the default queuing discipline.

Thanks.  That should give me enough to track down what I'm looking for.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

