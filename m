Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbVG3Sij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbVG3Sij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbVG3ShM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:37:12 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:14464 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263099AbVG3Sga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:36:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XF/8ZIB81ukTStJT9/bptH1fvyssGlKrpX/llA5oGla3aqotPRsBSIj6FM6HLKoqjzaZuJbiOrYuQ26dmwKnQXXP+8RiXySvJ370s+0m4Kyl5p+E3nTJ6cAy4brdV8Nomc2qhTXibSOrhJCCsSNojJw1aPiHnUEy13DPXLtts6I=  ;
Message-ID: <42EBC8A6.7030403@yahoo.com>
Date: Sat, 30 Jul 2005 11:36:22 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance	Initiator
References: <429E15CD.2090202@yahoo.com> <1122744762.5055.10.camel@mulgrave>
In-Reply-To: <1122744762.5055.10.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2005-06-01 at 13:08 -0700, Alex Aizman wrote:
> 
>>This is open-iscsi/linux-iscsi-5 Initiator. This submission is ready for
>>inclusion into mainline kernel.
> 
> 
> OK, I tried to put this into scsi-misc.
> 
> FIB has taken your netlink number, so I changed it to 32
> 

OK. Hopefully that'll remain.

> __nlm_put() has had an updated prototype, which I can fix (although I'm
> not sure you're supposed to be using this function...)
> 
> I can't fix up the compile errors in iscsi_tcp.c:
> 

Yes, the 06/01 submission was for 2.6.11. It will not compile.

Here's the latest development tarball 0.3rc7:

http://www.open-iscsi.org/bits/open-iscsi-0.3rc7-383.tar.gz
(This, as well as all the previous code drops can be downloaded from 
http://www.open-iscsi.org/index.html#download.)

Will work on producing a new patchset for 2.6.13. The only pending item now is 
code style cleanup.

Changelog, etc. Monday 08/01 is the latest.

>   CC [M]  drivers/scsi/iscsi_tcp.o
> drivers/scsi/iscsi_tcp.c: In function `iscsi_hdr_extract':
> drivers/scsi/iscsi_tcp.c:160: warning: implicit declaration of function
> `iscsi_cnx_error'
> drivers/scsi/iscsi_tcp.c:161: error: `ISCSI_ERR_PDU_GATHER_FAILED'
> undeclared (first use in this function)
> drivers/scsi/iscsi_tcp.c:161: error: (Each undeclared identifier is
> reported only once
> drivers/scsi/iscsi_tcp.c:161: error: for each function it appears in.)
> drivers/scsi/iscsi_tcp.c: In function `iscsi_tcp_state_change':
> drivers/scsi/iscsi_tcp.c:1005: error: `ISCSI_ERR_CNX_FAILED' undeclared
> (first use in this function)
> drivers/scsi/iscsi_tcp.c: In function `iscsi_sendhdr':
> drivers/scsi/iscsi_tcp.c:1092: error: `ISCSI_ERR_CNX_FAILED' undeclared
> (first use in this function)
> drivers/scsi/iscsi_tcp.c: In function `iscsi_sendpage':
> drivers/scsi/iscsi_tcp.c:1141: error: `ISCSI_ERR_CNX_FAILED' undeclared
> (first use in this function)
> drivers/scsi/iscsi_tcp.c: In function `iscsi_data_xmit_more':
> drivers/scsi/iscsi_tcp.c:1707: error: `STOP_CNX_RECOVER' undeclared
> (first use in this function)
> drivers/scsi/iscsi_tcp.c: At top level:
> [...]
> 
> Do you have an updated driver that will work in the current tree?
> 
> Thanks,
> 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

