Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWBNCyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWBNCyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 21:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBNCyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 21:54:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62683 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750920AbWBNCyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 21:54:54 -0500
Date: Mon, 13 Feb 2006 21:54:43 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: avuton@gmail.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060214025443.GB8405@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, avuton@gmail.com, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <3aa654a40602130231p1c476e99paa986fa198951839@mail.gmail.com> <20060213023925.2b950eea.akpm@osdl.org> <3aa654a40602130251t174a5e4bg28a52a147cc9b2cf@mail.gmail.com> <20060213025603.2014f9bd.akpm@osdl.org> <20060213184442.464f0fc6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213184442.464f0fc6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 06:44:42PM -0800, Andrew Morton wrote:
 > Andrew Morton <akpm@osdl.org> wrote:
 > >
 > > Avuton Olrich <avuton@gmail.com> wrote:
 > > >
 > > > I should have realized that would happen, hopefully here's a better
 > > >  one. Please let me know anything I can do to help.
 > > > 
 > > >  http://68.111.224.150:8080/~sbh/P1010031.JPG
 > > 
 > > Thanks.  Yes, it does look like the same bug.
 > 
 > argh.   The fix for this oops is still languishing in David's tree.

I was waiting for it to turn up in an -mm release first to be
sure everything was ok.

If you're ok with it going as is, Linus, please pull
from master.kernel.org:/pub/scm/linux/kernel/git/davej/cpufreq.git/
to get the changesets below.

		Dave


commit 7d5e350fab47f1273bc8b52d5f133ed6e4baeb7f
Author: Dave Jones <davej@redhat.com>
Date:   Thu Feb 2 17:03:42 2006 -0500

    [CPUFREQ] Whitespace/CodingStyle cleanups

    Signed-off-by: Dave Jones <davej@redhat.com>

commit a85f7bd310dbc9010309bfe70b6b02432a11ef59
Author: Thomas Renninger <trenn@suse.de>
Date:   Wed Feb 1 11:36:04 2006 +0100

    [CPUFREQ] Check whether driver init did not initialize current freq

    Check whether driver init did not initialize current freq

    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Dave Jones <davej@redhat.com>

commit 9d2725bb815d915fc6c8531097d9e71b579a8763
Author: Thomas Renninger <trenn@suse.de>
Date:   Wed Feb 1 11:38:37 2006 +0100

    [CPUFREQ] Check for not initialized freq on cpufreq changes

    Test for old_freq equals 0 to insure not to divide by 0:
    ______________________________________________

    Check for not initialized freq on cpufreq changes

    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Dave Jones <davej@redhat.com>

commit e4472cb3706ceea42797ae1dc79d624026986694
Author: Dave Jones <davej@redhat.com>
Date:   Tue Jan 31 15:53:55 2006 -0800

    [CPUFREQ] cpufreq_notify_transition cleanup.

    Introduce caching of cpufreq_cpu_data[freqs->cpu], which allows us to
    make the function a lot more readable, and as a nice side-effect, it
    now fits in < 80 column displays again.

    Signed-off-by: Dave Jones <davej@redhat.com>

