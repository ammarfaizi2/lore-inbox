Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVELKQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVELKQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 06:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVELKQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 06:16:32 -0400
Received: from smtpout.azz.ru ([81.176.69.27]:8848 "HELO smtpout.azz.ru")
	by vger.kernel.org with SMTP id S261395AbVELKQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 06:16:22 -0400
Message-ID: <42832D48.2080204@vlnb.net>
Date: Thu, 12 May 2005 14:17:44 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       iscsitarget-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       dmitry_yus@yahoo.com, Sander <sander@humilis.net>,
       David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: several messages
References: <1416215015.20050504193114@dns.toxicfilms.tv> <1115236116.7761.19.camel@dhollis-lnx.sunera.com> <1104082357.20050504231722@dns.toxicfilms.tv> <1115305794.3071.5.camel@dhollis-lnx.sunera.com> <20050507150538.GA800@favonius> <Pine.LNX.4.60.0505102352430.9008@poirot.grange> <4281C8A3.20804@vlnb.net> <Pine.LNX.4.60.0505112309430.8122@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0505112309430.8122@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Hello and thanks for the replies
> 
> On Wed, 11 May 2005, FUJITA Tomonori wrote:
> 
>>The iSCSI protocol simply encapsulates the SCSI protocol into the
>>TCP/IP protocol, and carries packets over IP networks. You can handle
> 
> ...
> 
> On Wed, 11 May 2005, Vladislav Bolkhovitin wrote:
> 
>>Actually, this is property not of iSCSI target itself, but of any SCSI target.
>>So, we implemented it as part of our SCSI target mid-level (SCST,
>>http://scst.sourceforge.net), therefore any target driver working over it will
>>automatically benefit from this feature. Unfortunately, currently available
>>only target drivers for Qlogic 2x00 cards and for poor UNH iSCSI target (that
>>works not too reliable and only with very specific initiators). The published
> 
> ...
> 
> The above confirms basically my understanding apart from one "minor" 
> confusion - I thought, that parallel to hardware solutions pure software 
> implementations were possible / being developed, like a driver, that 
> implements a SCSI LDD API on one side, and forwards packets to an IP 
> stack, say, over an ethernet card - on the initiator side. And a counter 
> part on the target side. Similarly to the USB mass-storage and storage 
> gadget drivers?

There is some confusion in the SCSI world between SCSI as a transport 
and SCSI as a commands set and software communication protocol, which 
works above the transport. So, you can implement SCSI transport at any 
software (eg iSCSI) or hardware (parallel SCSI, Fibre Channel, SATA, 
etc.) way, but if the SCSI message passing protocol is used overall 
system remains SCSI with all protocol obligations like task management. 
So, pure software SCSI solution is possible. BTW, there are pure 
hardware iSCSI implementations as well.

Vlad

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

