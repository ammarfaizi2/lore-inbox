Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVEAXed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVEAXed (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 19:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVEAXe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 19:34:28 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:44069 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261426AbVEAXeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 19:34:18 -0400
Message-ID: <427567AB.8060904@danbbs.dk>
Date: Mon, 02 May 2005 01:35:07 +0200
From: Mogens Valentin <monz@danbbs.dk>
Reply-To: monz@danbbs.dk
Organization: Mr Dev
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: "K.R. Foley" <kr@cybsft.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc3 won't boot from aic7899
References: <4269C60C.3070700@cybsft.com> <1114716611.5022.6.camel@mulgrave>	 <4271413F.70809@cybsft.com> <1114719624.5022.14.camel@mulgrave> <427146F3.5060605@cybsft.com>
In-Reply-To: <427146F3.5060605@cybsft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:

 > James Bottomley wrote:
 >
 >>
 >>> Apr 24 23:23:30 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI 
SCSI HBA DRIVER, Rev 6.2.36
 >>> Apr 24 23:23:30 porky kernel:         <Adaptec aic7899 Ultra160 
SCSI adapter>
 >>> Apr 24 23:23:30 porky kernel:         aic7899: Ultra160 Wide 
Channel B, SCSI Id=7, 32/253 SCBs
 >>> Apr 24 23:23:30 porky kernel: Apr 24 23:23:30 porky kernel: 
(scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
 >>> Apr 24 23:23:31 porky kernel:   Vendor: SEAGATE   Model: SX118273LC 
        Rev: 6679
 >>
 >>
 >> Yes, that's what I suspected.  Here the internal aic7xxx DV has silently
 >> configured the drive to be narrow.  Probably because of cable damage or
 >> something else.
 >>
 > Sorry I missed this before. The reason it is doing this is because 
this drive is connected using an adapter that converts an LC/LV (is this 
correct, off the top of my head) interface into a standard SCSI (narrow) 
interface. Could this be HELPING me here?


Probably the opposite, but thats what you meant anyway, right :-

I saw this on two Intel 440LX dual pIII 500/550 mobos, a bit different 
in age and scsi composition.
I didn't install on either, but neither mobos wouldn't recognize _any_ 
disks to better than 20MB/s, if at all, using some unnamed converter.
Same disks (IBM 18G DDYS 10K + 9G DNES 7200) worked just fine with same 
converter and a 29160 controller.


-- 
Kind regards,
Mogens Valentin

