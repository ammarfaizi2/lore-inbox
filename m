Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261285AbTCFXsc>; Thu, 6 Mar 2003 18:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbTCFXsc>; Thu, 6 Mar 2003 18:48:32 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:62479 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261285AbTCFXsb>; Thu, 6 Mar 2003 18:48:31 -0500
Date: Thu, 6 Mar 2003 23:59:04 +0000
From: John Levon <levon@movementarian.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HT and idle = poll
Message-ID: <20030306235904.GA58512@compsoc.man.ac.uk>
References: <200303052318.04647.habanero@us.ibm.com> <b487l2$1tn$1@penguin.transmeta.com> <17740000.1046989368@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17740000.1046989368@flay>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18r5GS-0000UK-00*BDL7FOllh6k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 02:22:48PM -0800, Martin J. Bligh wrote:

> BTW, could someone give a brief summary of why idle=poll is needed for 
> oprofile, I'd love to add it do the "documentation for dummies" file I
> was writing.

Because events like CPU_CLK_UNHALTED don't tick when the cpu is halted,
so the idle time doesn't show up properly in the kernel profile.
idle=poll doesn't hlt so the profile for poll_idle() reflects the actual
idle percentage.

Something like that anyway.

john
