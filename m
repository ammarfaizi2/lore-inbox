Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWAYUIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWAYUIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWAYUIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:08:19 -0500
Received: from mx.pathscale.com ([64.160.42.68]:41195 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932162AbWAYUIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:08:19 -0500
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: eranian@hpl.hp.com
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060124150912.GB7130@frankl.hpl.hp.com>
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com>
	 <1137775645.28944.61.camel@serpentine.pathscale.com>
	 <20060124150912.GB7130@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 12:08:13 -0800
Message-Id: <1138219693.15295.13.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 07:09 -0800, Stephane Eranian wrote:

> Because I tried regrouping all the /proc AND related interface into a single
> C file.

sysctls seem to be every bit as deprecated as /proc for what you are
tring to do.

> Well, it is not clear to me what criteria is used for /sys vs /proc.

My understanding is that only process-related stuff belongs in /proc
now.  Other random cruft that has accumulated over the years is left
there for backwards compatibility, but /sys interfaces are the way
forward now.

Some interfaces have already moved out of /proc in part or in whole, so
for example some ACPI functionality remains in /proc, while other bits
have moved to /sys/power.

The perfmon stuff may belong in a new hierarchy, for example
like /sys/class/pfm, or perhaps in /sys/devices/system/cpu.  Someone
like Greg K-H can put you to rights there.

	<b

