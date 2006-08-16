Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWHPDyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWHPDyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWHPDyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:54:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750890AbWHPDx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:53:59 -0400
Date: Tue, 15 Aug 2006 23:53:52 -0400
From: Dave Jones <davej@redhat.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: peculiar suspend/resume bug.
Message-ID: <20060816035351.GB17481@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060815221035.GX7612@redhat.com> <1155687599.3193.12.camel@nigel.suspend2.net> <20060816003728.GA3605@redhat.com> <20060816024140.GA30814@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816024140.GA30814@srcf.ucam.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 03:41:40AM +0100, Matthew Garrett wrote:
 > On Tue, Aug 15, 2006 at 08:37:28PM -0400, Dave Jones wrote:
 > 
 > > cpufreq-applet crashes as soon as the cpu goes offline.
 > > Now, the applet should be written to deal with this scenario more
 > > gracefully, but I'm questioning whether or not userspace should
 > > *see* the unplug/replug that suspend does at all.
 > 
 > As Nigel mentioned, cpu unplug happens just before processes are frozen, 
 > so I guess there's a chance for it to be scheduled. On the other hand, 
 > it's not unreasonable for CPUs to be unplugged during runtime anyway - 
 > perhaps userspace should be able to deal with that?

Sure, I'm not debating that point. It's a bug in the applet that needs fixing,
but it also seems that we could be saving a whole lot of pain by
hiding this from userspace at suspend/resume time.

		Dave

-- 
http://www.codemonkey.org.uk
