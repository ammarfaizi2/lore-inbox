Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbTCTPg4>; Thu, 20 Mar 2003 10:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbTCTPg4>; Thu, 20 Mar 2003 10:36:56 -0500
Received: from trained-monkey.org ([209.217.122.11]:49417 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S261499AbTCTPgz>; Thu, 20 Mar 2003 10:36:55 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jeff Garzik <garzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixup warning for acenic
References: <14240000.1048146629@[10.10.2.4]>
From: Jes Sorensen <jes@wildopensource.com>
Date: 20 Mar 2003 10:47:49 -0500
In-Reply-To: "Martin J. Bligh"'s message of "Wed, 19 Mar 2003 23:50:29 -0800"
Message-ID: <m365qenioq.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Martin" == Martin J Bligh <mbligh@aracnet.com> writes:

Martin> OK, it's war on warnings hour. Get this from acenic,
Martin> drivers/net/acenic.c:135: warning: `acenic_pci_tbl' defined
Martin> but not used

Martin> And indeed it doesn't *seem* to be used (though I'm less than
Martin> confident about that) ... can we just rip it out? Or should
Martin> this be wrapped in #ifdef MODULE or something (I'm compiling
Martin> it in)?

Hi Martin,

The table isn't used at the moment, however at some point it should
be. I have been reluctant to change the driver over to the new hotplug
scheme since in the past there has been a significant number of AceNIC
users running on older kernels which do not have the hotplug
infrastructure (2.4.9 etc). On the other hand I don't remember hearing
from a single person who wanted to use AceNIC in a hotplug
environment.

Anyway most people seems to be at 2.4.18 or later these days so maybe
it is time to retire the old code. I will try to find time to take a
look at it (or if someone beats me to it and sends me a patch ... ;-)

Cheers,
Jes

PS: There is an email address listed in the driver, please CC patches
to it.
