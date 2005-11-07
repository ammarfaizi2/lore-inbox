Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVKGXwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVKGXwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVKGXwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:52:51 -0500
Received: from web32402.mail.mud.yahoo.com ([68.142.207.195]:37496 "HELO
	web32402.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030197AbVKGXwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:52:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nmGqjyeRUrnjCGT/7ThLXwAwYW0Tt6iaqyI278ot0s4O5JJI9jlQ7KCM8VHXkMf18tI3789vTmQ7MVUY/zvApYUljlqhB7MSJyI0UT+ifI20dvFGebFO5UskjWSfOzprxal/A+UVDk3ep0uF0G0ep8Q8bQXtpP+qET4WHYi+Kqk=  ;
Message-ID: <20051107235247.67981.qmail@web32402.mail.mud.yahoo.com>
Date: Mon, 7 Nov 2005 15:52:47 -0800 (PST)
From: Anil kumar <anils_r@yahoo.com>
Subject: bus_to_virt equivalent
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to port bus_to_virt and virt_to_bus to the
DMA-mapping scheme.
I found a way to move virt_to_bus() as follows:
page = virt_to_page(cmd->request_buffer);
offset = (unsigned long)address & ~PAGE_MASK;
dma_addr_t addr = pci_map_page(dev, page, offset,
size,direction);

But now I want to get virtual address for dma_addr_t.

Any help is greatly appreciated.

with regards,
  Anil


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
