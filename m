Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTIPPVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbTIPPVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:21:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:41232 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261932AbTIPPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:21:36 -0400
Message-ID: <3F672A9A.9060809@techsource.com>
Date: Tue, 16 Sep 2003 11:22:02 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
References: <20030916102113.0f00d7e9.skraw@ithnet.com>	<Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephan von Krawczynski wrote:
> On Tue, 16 Sep 2003 10:11:49 -0300 (BRT)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com.br> wrote:
> 
> 
>>Oh... Jens just pointed bounce buffering is needed for the upper 2Gs. 
>>
>>Maybe you have a SCSI card+disks to test ? 8)
> 
> 
> Well, I do understand the bounce buffer problem, but honestly the current way
> of handling the situation seems questionable at least. If you ever tried such a
> system you notice it is a lot worse than just dumping the additional ram above
> 4GB. You can really watch your network connections go bogus which is just
> unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> do something useful with the beyond-4GB ram parts?
> We should not leave the current bad situation as is...

If there were some kind of tracking to determine which processes are 
doing I/O which requires the process to be in low memory.  Then, 
processes can be migrated around in physical memory so as to optimize 
for that.

Or is that already being done?

