Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUDPSY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUDPSY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:24:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56705 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263580AbUDPSY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:24:58 -0400
Message-ID: <408024CA.8000401@us.ibm.com>
Date: Fri, 16 Apr 2004 13:24:10 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "Mukker, Atul" <Atulm@lsil.com>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RELEASE]: megaraid unified driver version 2.20.0.B1
References: <0E3FA95632D6D047BA649F95DAB60E570230C7DB@exa-atlanta.se.lsil.com> <40801F5D.7030100@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 6) Kill uses of "volatile".  _Most_ of the time, this indicates buggy 
> code.  You should have the proper barriers in place:  mb(), wmb(), 
> rmb(), barrier(), and cpu_relax().  This has been mentioned before :)

I'm not sure I totally agree with this statement. I took a quick look at the driver
and the volatile appears to be used to point to host memory that is modified
by the adapter. Correct me if I am wrong, but memory barriers will not accomplish
what the volatile will in this situation.



-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

