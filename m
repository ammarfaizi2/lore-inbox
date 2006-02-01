Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWBAIGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWBAIGD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 03:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWBAIGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 03:06:03 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:64456 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750705AbWBAIGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 03:06:01 -0500
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch -mm4] i386: __init should be __cpuinit
In-Reply-To: <20060201053357.GA5335@redhat.com>
References: <200601312352_MC3-1-B748-FCE9@compuserve.com> <200601312352_MC3-1-B748-FCE9@compuserve.com> <20060201053357.GA5335@redhat.com>
Date: Wed, 1 Feb 2006 08:05:51 +0000
Message-Id: <E1F4Czv-00018m-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:

> Especially as for the bulk of them, those CPUs aren't hotplug capable.
> (I seriously doubt we'll ever see a hotplugable cyrix for eg, which
>  takes up the bulk of your diff).

For SMP systems, suspend/resume "unplugs" all non-boot CPUs before
executing the suspend code. I don't recall any SMP cyrix systems, but
it's potentially something to consider.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
