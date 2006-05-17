Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWEQSIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWEQSIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWEQSIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:08:12 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:58893 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750835AbWEQSIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:08:11 -0400
X-IronPort-AV: i="4.05,138,1146466800"; 
   d="scan'208"; a="1807996892:sNHT30805856"
To: Dave Olson <olson@unixfolk.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 35 of 53] ipath - some interrelated stability and cleanliness fixes
X-Message-Flag: Warning: May contain useful information
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
	<fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no>
	<Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 17 May 2006 11:08:09 -0700
In-Reply-To: <Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com> (Dave Olson's message of "Wed, 17 May 2006 09:47:59 -0700 (PDT)")
Message-ID: <ada4pzo5xti.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 May 2006 18:08:09.0752 (UTC) FILETIME=[DAD0C980:01C679DC]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dave> We are seeing a bug (with both our driver native MPI
    Dave> processes and mthca mvapic), where when 8 processes using
    Dave> "simultaneously exit", we get watchdogs and/or hangs in the
    Dave> close routines.  Moving the freeing outside the mutex was an
    Dave> attempt to see if we were running into some VM issues by
    Dave> doing lots of page unlocking and freeing with the mutex
    Dave> held.  It seemed to help somewhat, but not to solve the
    Dave> problem.

Am I understanding correctly that you see a hang or watchdog timeout
even with the mthca driver?

Is there any possibility of posting the test case to reproduce this?
It doesn't seem likely that ipath changes are going to fix a generic
bug like this...

 - R.
