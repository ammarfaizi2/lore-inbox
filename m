Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277945AbRJRSbl>; Thu, 18 Oct 2001 14:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277924AbRJRSbW>; Thu, 18 Oct 2001 14:31:22 -0400
Received: from web1.guha.com ([140.174.164.125]:51974 "HELO alpiri.com")
	by vger.kernel.org with SMTP id <S277933AbRJRSbR>;
	Thu, 18 Oct 2001 14:31:17 -0400
Message-ID: <3BCF209A.7010609@robm.com>
Date: Thu, 18 Oct 2001 11:34:02 -0700
From: Rob McCool <robm@robm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: disk lockup after suspend with RH 2.4.9-0.18 and 2.4.12
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Acer Travelmate 721 laptop on which I was running kernel 2.2.18, and have 
upgraded first to Red Hat's rawhide 2.4.9-0.18 kernel, and then to 2.4.12 from the 
sources. I put it back to 2.4.9 for the moment. I've been seeing the same behavior on both 
kernels, which I hadn't seen under 2.2.

After the disk goes into standby or sleep mode, the system gets into a wedged state. If I 
do something that hits the drive, I can hear it spin up again, but the kernel doesn't seem 
to notice. At that point, any process that tries to access the disk gets wedged. This is 
reproducible by either doing an APM suspend/resume, or by using hdparm -S1 ..., or by 
using hdparm -y ... and doing something to awaken it. After awakening, processes which 
only access the CPU are fine but anything which accesses the disk wedges. This means 
things like new network connections are accepted (but not acted upon), shell processes 
run, and the X server works for a while, but eventually all hang.

I've tried changing configuration options in the APM module, including the ones related to 
interrupts during APM operations, but nothing seems to help. I have a copy of 2.4.2 lying 
around which I didn't use because I needed the Orinoco driver, so I don't know yet if this 
problem happens with 2.4.2.

Does anybody know what might cause this, or have any pointers of how I can narrow this 
down further? If someone can point me to which part of the kernel this may be happening 
in, or give any suggestions about what might be happening and how specifically to diagnose 
it, it would help.

Thanks, Rob

