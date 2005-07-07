Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVGGTfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVGGTfH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVGGTdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:33:25 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:29676 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S262074AbVGGTbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:31:18 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <42CD82CD.5040903@s5r6.in-berlin.de>
Date: Thu, 07 Jul 2005 21:30:21 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: Jody McIntyre <scjody@modernduck.com>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/ieee1394/: schedule unused EXPORT_SYMBOL's
 for removal (fwd)
References: <20050703232405.GR5346@stusta.de> <20050707144513.GG10001@conscoop.ottawa.on.ca>
In-Reply-To: <20050707144513.GG10001@conscoop.ottawa.on.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.556) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre wrote:
> On Mon, Jul 04, 2005 at 01:24:05AM +0200, Adrian Bunk wrote:
>>What shall I do?
>>- resend this patch with the removal date set to August or
> 
> That should be fine.  I'll watch for it this time.  August isn't much
> time though; isn't the "standard" 6 months to a year?

August is fine; it's our sloppiness that the remove announcement did not 
go in earlier. People who run external projects that use such symbols 
might have had forewarning by the previous discussion rounds on 
linux1394-devel.

>>+What:	remove the following ieee1394 EXPORT_SYMBOL's:
>>+	- hpsb_send_phy_config
>>+	- hpsb_send_packet_and_wait
>>+	- highlevel_add_host
>>+	- highlevel_remove_host
>>+	- nodemgr_for_each_host
>>+	- csr1212_create_csr
>>+	- csr1212_init_local_csr
>>+	- csr1212_new_immediate
>>+	- csr1212_associate_keyval
>>+	- csr1212_new_string_descriptor_leaf
>>+	- csr1212_destroy_csr
>>+	- csr1212_generate_csr_image
>>+	- csr1212_parse_csr

Now that we are at it, the following EXPORT_SYMBOLs should be removed too...
	_csr1212_read_keyval
	_csr1212_destroy_keyval

>>+Files:	drivers/ieee1394/ieee1394_core.c
>>+Why:	No modular usage in the kernel.

...at the same place and for the same reason.
-- 
Stefan Richter
-=====-=-=-= -=== --===
http://arcgraph.de/sr/
