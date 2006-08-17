Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWHQNn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWHQNn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWHQNn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:43:57 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:44991 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964909AbWHQNny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:43:54 -0400
Date: Thu, 17 Aug 2006 15:41:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthew Wilcox <matthew@wil.cx>
cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Random scsi disk disappearing
In-Reply-To: <20060817115356.GM4340@parisc-linux.org>
Message-ID: <Pine.LNX.4.61.0608171541260.24557@yvahk01.tjqt.qr>
References: <44E44B3E.10708@tls.msk.ru> <20060817113537.GK4340@parisc-linux.org>
 <44E4567B.4080104@tls.msk.ru> <20060817115356.GM4340@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It should be the same as
>>    echo $((7<<6)) > /sys/module/scsi_mod/parameters/scsi_logging_level
>> (which indeed is 448) at runtime, right?  (And yes, CONFIG_SCSI_LOGGING
>> is set to y).
>
>> Heh oh those magic numbers!.. ;)
>
>> By the way, should kernel pefrorm at least *some* "minimal" logging of
>> such a serious events by default?  Well ok, ok, it's not known yet what
>> the event really is, so I'm shutting up now, at least for a while.. ;)
>
>That's the problem -- if it turns out the event is a reasonable thing to
>happen for some devices, we'll annoy everyone with those devices.  It's
>hard to please everybody ;-)

Since 7<<6 seems to indicate a flag, it would be best to have some sysfs 
variable that you can flip using 0 and 1.


Jan Engelhardt
-- 
