Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbSIZUPx>; Thu, 26 Sep 2002 16:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSIZUPw>; Thu, 26 Sep 2002 16:15:52 -0400
Received: from nl-ams-slo-l4-02-pip-5.chellonetwork.com ([213.46.243.22]:56379
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261400AbSIZUPw>; Thu, 26 Sep 2002 16:15:52 -0400
Message-ID: <3D936C30.6070609@users.sf.net>
Date: Thu, 26 Sep 2002 22:21:04 +0200
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
References: <3D92B450.2090805@pobox.com>	<20020926.001343.57159108.davem@redhat.com>	<3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com> <3D92C206.2050905@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:

> Although last time i tried Matt Jabob's driver, it locked up
> after 30 seconds of running bonnie. At least with Qlogic's
> driver I can run bonnie and cerberus continuously for 2 weeks
> with no problems (although this may have been because
> Matt's driver ignored the command queue throttle set in the
> qlogic cards BIOS).

My excerience with a JBOD box is the in kernel driver locking up with the "no 
handle slots, this should not happen" message in half an hour running a 4 MB/sec 
write load.

Then tried the feral.com driver. That one was stable with the same load. Ran 
that one for a month or two.

Then came along the highio patch in -AA. Made me want to switch to the in kernel 
qlogic driver again. This was a good time to try a patch by Andrew Patterson, 
AFAIR upping the number of slots to 255 and fixing the calculations around them. 
This has been running without problems for a few months now.

The patch has been posted to the list. It can be found at 
http://groups.google.com/groups?selm=linux.scsi.1019759258.2413.1.camel%40lvadp.fc.hp.com

> The qlogic HBAs are a real problem in choosing which driver
> to use out of:
> 
> in kernel qlogicfc
> Qlogic's qla2x00 v4.x, v5.x, v6.x
> Matthew Jacob's isp_mod

I never tried Qlogic's driver, probably because of all the versions floating around.


Thomas


