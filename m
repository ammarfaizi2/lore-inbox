Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289551AbSBKOF4>; Mon, 11 Feb 2002 09:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289386AbSBKOFu>; Mon, 11 Feb 2002 09:05:50 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:34181 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S289551AbSBKOFe>; Mon, 11 Feb 2002 09:05:34 -0500
Message-ID: <3C67CFFB.7040300@oracle.com>
Date: Mon, 11 Feb 2002 15:06:51 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.4 build - IrDA issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just finished building 2.5.4 after

  1 - applying akpm's patch
  2 - removing Maestro3 sound support
  3 - switching from xircom_tulip_cb to xircom_cb

Since 2 and 3 are already reported and known, here's one more to report:

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.4; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.4/kernel/net/irda/irda.o
depmod: 	virt_to_bus_not_defined_use_pci_map

--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")

