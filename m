Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSCZLSI>; Tue, 26 Mar 2002 06:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311203AbSCZLR6>; Tue, 26 Mar 2002 06:17:58 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:62873 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S311147AbSCZLRl>;
	Tue, 26 Mar 2002 06:17:41 -0500
Message-ID: <3CA05A47.9090602@SoftHome.net>
Date: Tue, 26 Mar 2002 19:23:51 +0800
From: Jason Xia <jasonxia@SoftHome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us, zh-cn, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about probe_roms
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
      I'm reading linux kernel 2.4 source code and puzzled with
probe_roms().
In this function , rom was probed and request_resource was called. but I
don't understand these codes:
      for (base = 0xC0000; base < 0xE0000; base+=2048) {
          romstart = bus_to_virt(base);
          if (!romsignature(romstart))
                  continue;
          request_resource(&iomem_resource, rom_resources+roms);
          roms++;
          break;
      }
Because whether video rom is start from  0xC000:0000 or not, we request
a memory
resource start at 0xC0000 (I don't find any code change the contents of
rom_resources)
So I think these codes assume that there is a video rom at 0xc0000,  but
if this is true,
why not request_resource as SystemRom?

Thank you in advance.

Best regards !

-- jason --




