Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRLEFgA>; Wed, 5 Dec 2001 00:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279814AbRLEFfv>; Wed, 5 Dec 2001 00:35:51 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:50049 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S278522AbRLEFfp>; Wed, 5 Dec 2001 00:35:45 -0500
Message-ID: <3C0DB22D.5050703@optonline.net>
Date: Wed, 05 Dec 2001 00:35:41 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Mikocevic <mozgy@hinet.hr>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA588.2080000@optonline.net> <3C0DAC2C.8060506@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Interesting...two seconds after the buffer ran out of data, quake 
> *finally* calls one of the ioctls that then calls i810_update_ptrs()...

mmap followed by SETTRIGGER is part of the sound init routine, in 
WinQuake/snd_linux.c. they probably call that on startup and don't get 
around to playing any sound until the rest of the game has booted up.

