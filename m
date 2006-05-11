Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWEKGLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWEKGLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 02:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWEKGLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 02:11:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965136AbWEKGLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 02:11:43 -0400
Date: Wed, 10 May 2006 23:06:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-Id: <20060510230606.076271b2.akpm@osdl.org>
In-Reply-To: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
> To remove multiple CPUs, we should iteratively do single cpu removal.
> If tasks and interrupts are migrated to a cpu which will be soon
> removed, then we will trash tasks and interrupts again. The following
> patches allow remove several cpus one time. It's fast and avoids
> unnecessary repeated trash tasks and interrupts. This will help NUMA
> style hardware removal and SMP suspend/resume. Comments and suggestions
> are appreciated.

This seems an awful lot of code for something which happens so infrequently.

How big is the problem you're fixing here, and what are the
user-observeable effects of these changes?
