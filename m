Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTIQOFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 10:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTIQOFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 10:05:35 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:15521 "EHLO
	natsmtp01.webmailer.de") by vger.kernel.org with ESMTP
	id S262760AbTIQOFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 10:05:34 -0400
Message-ID: <3F686A73.9080706@softhome.net>
Date: Wed, 17 Sep 2003 16:06:43 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Incremental update of TCP Checksum
References: <kysi.5h.17@gated-at.bofh.it> <mZy6.3NX.7@gated-at.bofh.it> <wtdD.3EP.13@gated-at.bofh.it> <wtnf.3Zv.9@gated-at.bofh.it> <wuMz.65Q.15@gated-at.bofh.it> <wBkH.7Sv.3@gated-at.bofh.it> <wKxN.5h0.7@gated-at.bofh.it>
In-Reply-To: <wKxN.5h0.7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> This is all wonderful. This assumes that the stuff being modified
> in the packet is on well-defined boundaries, seldom the case when
> you are re-writing packet data, but certainly the case if you
> are re-writing an IP address.
> 
> Also, modern switches do not rewrite checksums using software.
                                                        ^^^^^^^^
> Therefore, they do not use a re-write algorithm as stated by
> others. The checksum gets calculated "for free" during the
> hardware transfer to an output holding FIFO. It is done using
> an ASIC with the appropriate adder and "stumble-carry".
> 

   It depends on definition of software. It is so hard to draw parallel 
especially when what looks like controller runs some flavour of Linux 
from some embedded flash ;-)

   Actually some switches do alter header _before_ they have received 
payload. Just to be able to start rx without waiting for payload to 
arrive completely. Sometimes low latencies (even on narrow bandwidth 
links) are _that_ important...

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
   * Please avoid sending me Word/PowerPoint/Excel attachments.
   * See http://www.fsf.org/philosophy/no-word-attachments.html
   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
    There should be some SCO's source code in Linux -
       my servers sometimes are crashing.      -- People

