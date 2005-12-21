Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVLUQ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVLUQ7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVLUQ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:59:00 -0500
Received: from ip201.pianodisc.com ([207.173.133.201]:53520 "EHLO
	EXCHANGE01-Srv.pianodisc.com") by vger.kernel.org with ESMTP
	id S1751142AbVLUQ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:59:00 -0500
Message-ID: <43A989CF.3000901@pianodisc.com>
Date: Wed, 21 Dec 2005 08:58:55 -0800
From: Steve deRosier <derosier@pianodisc.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk> <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Dec 2005 16:58:55.0495 (UTC) FILETIME=[D3F63970:01C6064F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> I thought more people knew about all this. Forcing (or even just 
> encouraging) people to use loadable modules is just horrible. I personally 
> run a kernel with no modules at all: it makes for a simpler bootup, and in 
> some situations (embedded) it has both security and size advantages.
> 

Linus,

I'm glad you said that and I have to second that opinion.  

On our current product, we compile everything we need into the kernel; we don't use Alsa as modules at all.  Our system is "embedded" as far as the user is concerned (though in many ways is just a general purpose computer running a custom stripped down distribution), and the monolithic kernel is critical to our boot speed (under 1 minute till all services are running) and filesystem size.  

In addition, it makes maintenance and porting much easier: Step 1 - reconfigure and recompile the kernel; Step 2 - put bzImage in our update tarball.  Easy.  I can't imagine what a pain it would be to have to "install" the modules in our filesystem image.

Thankfully, we've never had to deal with this sort of failure; all of our Alsa drivers and services have been well behaved (mostly).

- Steve
