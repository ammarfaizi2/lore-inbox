Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278199AbRJLX3f>; Fri, 12 Oct 2001 19:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278200AbRJLX3Z>; Fri, 12 Oct 2001 19:29:25 -0400
Received: from postal2.lbl.gov ([131.243.248.26]:32458 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S278199AbRJLX3Q>;
	Fri, 12 Oct 2001 19:29:16 -0400
Message-ID: <3BC77BC2.934C2CC@lbl.gov>
Date: Fri, 12 Oct 2001 16:24:50 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac1
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI compiles as module, but complains about missing symbols:

cd /lib/modules/2.4.12-ac1; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.12-ac1;
fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.12-ac1/kernel/drivers/acpi/ospm/system/ospm_system.o
depmod:         dmi_broken
depmod:         init_8259A

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
