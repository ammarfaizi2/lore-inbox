Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263315AbVCKOZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbVCKOZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbVCKOZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:25:34 -0500
Received: from post.rzg.mpg.de ([130.183.7.21]:32764 "EHLO post.rzg.mpg.de")
	by vger.kernel.org with ESMTP id S263315AbVCKOZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:25:11 -0500
Subject: bonnie++ uninterruptible under heavy I/O load
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: fabio.coatti@wseurope.com
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
       simone.piunno@wseurope.com
Content-Type: text/plain
Date: Fri, 11 Mar 2005 15:24:59 +0100
Message-Id: <1110551100.7733.3.camel@bonnie.rzg.mpg.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> > Unresponsiveness is not 2.6.11 specific (we've seen the same thing on
>> > 2.6.10 and 2.6.8), not I/O scheduler specific ("as" and "deadline" behave
>> > the same) and not CPU/SMP specific (reproduced on single P4 HT and single
>> > P3), but only on these two DL585 servers we've seen bonnie++ resisting
>> > kill -9 for tens of seconds.
>> >
>> > Of course on request I can provide any other useful info.
>> > Any help is appreciated.
>>
>> I think Alt-SysRq-T will be interesting to see
>
>Unfortunately this machine is on a remote location, so we don't have access to 
>keyboard. In some days we will be able to have a report of Alt-SysRq-T, but 
>until this  of course we can provide any information that can be gathered on 
>a remote shell.

what about a: (if sysrq was enabled in the kernel)

echo "1" > /proc/sys/kernel/sysrq
echo "6" > /proc/sysrq-trigger
echo "t" > /proc/sysrq-trigger

 - Christian



