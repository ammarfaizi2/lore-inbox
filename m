Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWFLMZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWFLMZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWFLMZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:25:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751910AbWFLMZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:25:36 -0400
Date: Mon, 12 Jun 2006 08:25:10 -0400
From: Dave Jones <davej@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] revert "swsusp: fix breakage with swap on lvm"
Message-ID: <20060612122510.GA26600@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <200603231702.k2NH2MUS006739@hera.kernel.org> <20060612000859.GA16992@redhat.com> <200606121221.13867.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606121221.13867.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 12:21:13PM +0200, Rafael J. Wysocki wrote:

 > > So, now I'm getting bug reports from users about .17rc breaking
 > > their resume again. (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=194784)
 > > 
 > > If this was a temporary thing, what should we be doing to keep
 > > old installations working ?
 > 
 > This was temporary, because the handling of it has been moved to
 > kernel/power/swap.c and mm/swapfile.c now, but the code has not changed much
 > (surely it doesn't return -ENODEV if swsusp_resume_device is not set).
 > Moreover, the new code has been in -rc since 2.6.17-rc1.
 > 
 > The report you are referring to is for the kernel called 2.6.16-1.2255_FC6. 
 > Is this just 2.6.17-rc* renamed or is it related to -rc in another way?

Yes, it's .17rc6.
(They only become a 2.6.17-x after .17 is final)

		Dave

-- 
http://www.codemonkey.org.uk
