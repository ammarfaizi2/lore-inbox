Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVGUGXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVGUGXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 02:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVGUGXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 02:23:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:12732 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261658AbVGUGXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 02:23:19 -0400
Date: Thu, 21 Jul 2005 08:22:25 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paul Jackson <pj@sgi.com>
cc: mrmacman_g4@mac.com, linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
In-Reply-To: <20050720174521.73c06bce.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0507210814580.15745@yvahk01.tjqt.qr>
References: <20050714011208.22598.qmail@science.horizon.com>
 <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com> <Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr>
 <20050720174521.73c06bce.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> (Find source files, expand tab chars to their on-screen length, print if 
>> >= 80, count lines)
>
>The bulk of the longest lines are in the sound and drivers subtrees.
>One example on the "high end", with 546 chars in one line:
>
>==
>drivers/scsi/BusLogic.c:
>  %2d	 %5d %5d %5d    %5d %5d %5d	   %5d %5d %5d\n", TargetID, TargetStatistics[TargetID].CommandAbortsRequested, TargetStatistics[TargetID].CommandAbortsAttempted, TargetStatistics[TargetID].CommandAbortsCompleted, TargetStatistics[TargetID].BusDeviceResetsRequested, TargetStatistics[TargetID].BusDeviceResetsAttempted, TargetStatistics[TargetID].BusDeviceResetsCompleted, TargetStatistics[TargetID].HostAdapterResetsRequested, TargetStatistics[TargetID].HostAdapterResetsAttempted, TargetStatistics[TargetID].HostAdapterResetsCompleted);
>==

this is omg.
- the VLN BASIC way (very long variable names)
- it could have been splitted at the next possible space at 80, i.e.
  mostly after a comma (my mail _reader_ automatically wrapped it, so it
  looked rather ok - until I took an _editor_)

If I add a temporary (as suggested by rule 3)
(struct BusLogic_Statistics *tp = &TargetStatistics[TargetID]), the line
length loses a lot of weight: 339 chars.

>  %2d	 %5d %5d %5d    %5d %5d %5d	   %5d %5d %5d\n", TargetID, TargetStatistics[TargetID].CommandAbortsRequested, TargetStatistics[TargetID].CommandAbortsAttempted, TargetStatistics[TargetID].CommandAbortsCompleted, TargetStatistics[TargetID].BusDeviceResetsRequested, TargetStatistics[TargetID].BusDeviceResetsAttempted, TargetStatistics[TargetID].BusDeviceResetsCompleted, TargetStatistics[TargetID].HostAdapterResetsRequested, TargetStatistics[TargetID].HostAdapterResetsAttempted, TargetStatistics[TargetID].HostAdapterResetsCompleted);


Jan Engelhardt
-- 
