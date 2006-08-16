Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWHPClx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWHPClx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWHPClx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:41:53 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:38306 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750835AbWHPClx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:41:53 -0400
Date: Wed, 16 Aug 2006 03:41:40 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dave Jones <davej@redhat.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: peculiar suspend/resume bug.
Message-ID: <20060816024140.GA30814@srcf.ucam.org>
References: <20060815221035.GX7612@redhat.com> <1155687599.3193.12.camel@nigel.suspend2.net> <20060816003728.GA3605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816003728.GA3605@redhat.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 08:37:28PM -0400, Dave Jones wrote:

> cpufreq-applet crashes as soon as the cpu goes offline.
> Now, the applet should be written to deal with this scenario more
> gracefully, but I'm questioning whether or not userspace should
> *see* the unplug/replug that suspend does at all.

As Nigel mentioned, cpu unplug happens just before processes are frozen, 
so I guess there's a chance for it to be scheduled. On the other hand, 
it's not unreasonable for CPUs to be unplugged during runtime anyway - 
perhaps userspace should be able to deal with that?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
