Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263896AbTHVPgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTHVPgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:36:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15021 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263935AbTHVPgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:36:46 -0400
Message-ID: <3F46386A.4080009@us.ibm.com>
Date: Fri, 22 Aug 2003 08:36:10 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: help???  trying to trace code path of outgoing udp packet
References: <3F46356A.804@nortelnetworks.com>
In-Reply-To: <3F46356A.804@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> ip_finish_output     ip_output.c
> ip_finish_output2    ip_output.c   dst->neighbour->output

|
V
dev_queue_xmit()
qdisc_run()
qdisc_restart()
dev->hard_start_xmit() [driver xmit routine]

this is for the default queuing discipline.

thanks,
Nivedita


