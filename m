Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132440AbRCZOI3>; Mon, 26 Mar 2001 09:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132442AbRCZOIT>; Mon, 26 Mar 2001 09:08:19 -0500
Received: from mail.xmission.com ([198.60.22.22]:43787 "EHLO mail.xmission.com")
	by vger.kernel.org with ESMTP id <S132440AbRCZOII>;
	Mon, 26 Mar 2001 09:08:08 -0500
Message-ID: <3ABF4D3D.2070401@xmission.com>
Date: Mon, 26 Mar 2001 07:07:57 -0700
From: Frank Jacobberger <f1j@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre7 i686; en-US; 0.8.1) Gecko/20010322
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre8 problem with 8139too - failure to load
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something has changed regarding the 8139too driver in pre8.

I worked on it all morning long trying to resolve why the sucker
failed to load. There are new configuration options that need to
be addressed. As you recall there were zippo options in the pre7.

There are now:

RealTek RTL-8139 PCI Fast Ethernet Adapter support      [M]      
  Use PIO instead of MMIO                                               
      [*]    
  Support for automatic channel equalization (EXPERIMENTAL)   [ ]    
  Support for older RTL-8129/8130 boards                            [*]

Doing any combination of the above netted no positive result here.

I have run every kernel patch since 2.4.0 blah and
have never seen this driver fail to load or perform to some degree.

Trying to do insmod 8139too.o from the :
/lib/modules/2.4.3-pre8/kernel/drivers/net directory show these
unresolved symbols:

8139too.o: unresolved symbol alloc_etherdev
8139too.o: unresolved symbol unregister_netdev
8139too.o: unresolved symbol register_netdev

Maybe Jeff can shed more light on these changes....

Thanks,

Frank

