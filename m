Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWHPIvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWHPIvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWHPIvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:51:00 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:47532 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751024AbWHPIu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:50:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: peculiar suspend/resume bug.
Date: Wed, 16 Aug 2006 10:54:51 +0200
User-Agent: KMail/1.9.3
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060815221035.GX7612@redhat.com> <20060816024140.GA30814@srcf.ucam.org> <20060816035351.GB17481@redhat.com>
In-Reply-To: <20060816035351.GB17481@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161054.52037.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 16 August 2006 05:53, Dave Jones wrote:
> On Wed, Aug 16, 2006 at 03:41:40AM +0100, Matthew Garrett wrote:
>  > On Tue, Aug 15, 2006 at 08:37:28PM -0400, Dave Jones wrote:
>  > 
>  > > cpufreq-applet crashes as soon as the cpu goes offline.
>  > > Now, the applet should be written to deal with this scenario more
>  > > gracefully, but I'm questioning whether or not userspace should
>  > > *see* the unplug/replug that suspend does at all.
>  > 
>  > As Nigel mentioned, cpu unplug happens just before processes are frozen, 
>  > so I guess there's a chance for it to be scheduled. On the other hand, 
>  > it's not unreasonable for CPUs to be unplugged during runtime anyway - 
>  > perhaps userspace should be able to deal with that?
> 
> Sure, I'm not debating that point. It's a bug in the applet that needs fixing,
> but it also seems that we could be saving a whole lot of pain by
> hiding this from userspace at suspend/resume time.

Yes, that's the plan, but for now the freezer is not SMP-friendly, so to
speak, and we have some work to do to make it possible.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
