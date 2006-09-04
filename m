Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWIDJ02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWIDJ02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWIDJ01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:26:27 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:30185 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751267AbWIDJ0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:26:24 -0400
Date: Mon, 4 Sep 2006 11:22:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 02/16] GFS2: Core locking interface
In-Reply-To: <1157360497.3384.888.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041108570.11217@yvahk01.tjqt.qr>
References: <1157030977.3384.786.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0609010852470.25521@yvahk01.tjqt.qr>
 <1157360497.3384.888.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


>Unfortunately thats not possible as the struct gfs2_sbd is actually
>changed lower down the call chain, but only in the lock_dlm module.

+void gfs2_lm_unmount(struct gfs2_sbd *sdp)
+{
+	if (likely(!test_bit(SDF_SHUTDOWN, &sdp->sd_flags)))
+		gfs2_unmount_lockproto(&sdp->sd_lockstruct);
+}

I can't follow... test_bit does not modify *sdp or sdp->sd_flags, and
gfs2_unmount_lockproto does not either.


>http://www.kernel.org/git/?p=linux/kernel/git/steve
/gfs2-2.6.git;a=commitdiff;h=5029996547a9f3988459e11955c13259495308ef

(Argh for browsers: while copy-and-paste from firefox to xterm compresses all
spaces (like s/ +/ /g), MSIE displays it compressed right away. The latter is
caused because it does not support the white-space:pre; CSS attribute. A
workaround for both browsers is to s/  / &nbsp;/g)



Jan Engelhardt
-- 

-- 
VGER BF report: H 0.000814757
