Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVGUApg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVGUApg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 20:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVGUApg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 20:45:36 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9088 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261579AbVGUApe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 20:45:34 -0400
Date: Wed, 20 Jul 2005 17:45:21 -0700
From: Paul Jackson <pj@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: mrmacman_g4@mac.com, linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Message-Id: <20050720174521.73c06bce.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr>
References: <20050714011208.22598.qmail@science.horizon.com>
	<FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com>
	<Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan wrote:
> (Find source files, expand tab chars to their on-screen length, print if 
> >= 80, count lines)

The bulk of the longest lines are in the sound and drivers subtrees.

One example on the "high end", with 546 chars in one line:

==

drivers/scsi/BusLogic.c:

  %2d	 %5d %5d %5d    %5d %5d %5d	   %5d %5d %5d\n", TargetID, TargetStatistics[TargetID].CommandAbortsRequested, TargetStatistics[TargetID].CommandAbortsAttempted, TargetStatistics[TargetID].CommandAbortsCompleted, TargetStatistics[TargetID].BusDeviceResetsRequested, TargetStatistics[TargetID].BusDeviceResetsAttempted, TargetStatistics[TargetID].BusDeviceResetsCompleted, TargetStatistics[TargetID].HostAdapterResetsRequested, TargetStatistics[TargetID].HostAdapterResetsAttempted, TargetStatistics[TargetID].HostAdapterResetsCompleted);

==

Clearly, it would be unrepresentative of certain coding styles in drivers
and sound to claim they closely followed an 80 column constraint.

Perhaps the spacing guide should acknowledge this, with some qualification
such as:

   The core kernel code (as apposed to some driver code) tends to keep
   source line lengths below 80 columns.  When changing such code, respect
   the line length constraints of nearby code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
