Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTJ3ViN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbTJ3ViN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:38:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51346 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262848AbTJ3ViJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:38:09 -0500
Message-ID: <3FA184B2.9030504@pobox.com>
Date: Thu, 30 Oct 2003 16:37:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Anton Blanchard <anton@samba.org>
Subject: Re: [Lse-tech] Re: 2.6.0-test9-mjb1
References: <14860000.1067544022@flay>  <3FA171DD.5060406@pobox.com>	 <1067548047.1028.19.camel@nighthawk>  <3FA17FEC.2080203@pobox.com> <1067549370.2657.38.camel@nighthawk>
In-Reply-To: <1067549370.2657.38.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Thu, 2003-10-30 at 13:17, Jeff Garzik wrote:
> 
>>well, there's still this patch...
>> void
>>-e1000_io_write(struct e1000_hw *hw, uint32_t port, uint32_t value)
>>+e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value)
>> {
>> 	outl(value, port);
>> }
> 
> 
> Whoops.  I just went looking in the breakout directory and didn't see it
> in there.  I wonder where it was hidden.  
> 
> Anton, did this come from you?  Did it stop some warnings or something?

"stop some warnings"?  ;)  It's obviously correct -- a port address 
_must_ be unsigned long.  Anything less is uncivilized (and a bug).

	Jeff



