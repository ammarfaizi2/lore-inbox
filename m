Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUHDFbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUHDFbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUHDFbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:31:09 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:13802 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267258AbUHDFbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:31:05 -0400
Subject: Re: MTRR driver model support broken on SMP.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408040128490.19619@montezuma.fsmlabs.com>
References: <1091585241.3303.6.camel@laptop.cunninghams>
	 <Pine.LNX.4.58.0408040119270.19619@montezuma.fsmlabs.com>
	 <1091596967.3189.86.camel@laptop.cunninghams>
	 <Pine.LNX.4.58.0408040128490.19619@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1091597484.3191.90.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 15:31:25 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 15:31, Zwane Mwaikambo wrote:
> On Wed, 4 Aug 2004, Nigel Cunningham wrote:
> 
> > > Looking at this i'm really curious as to whether we need to bother at all,
> > > can you remove the mtrr restore code and then compare /proc/mtrr before
> > > and after suspending.
> >
> > I haven't had problems but do remember 2.4 users who had trouble with X
> > before code to save and restore mtrrs was added.
> 
> Ahh yes, X11 will create an additional entry on startup whilst the
> boot MTRR settings don't have it.

Okay. So the question then is how to get them restored. I don't
understand much about the driver model, but it seems to me that all we
should need it get to mtrr save/restore done from the
drivers_suspend/resume calls, which do have interrupts enabled. But how
to achieve that...

Nigel

