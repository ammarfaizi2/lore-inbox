Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUKWVAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUKWVAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKWU7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:59:03 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:64958 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261610AbUKWU6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:58:36 -0500
Subject: Re: SELinux performance issue with large systems (32 cpus)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: keith <kmannth@us.ibm.com>
Cc: devnull@us.ibm.com, djwong <djwong@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1101237725.27848.301.camel@knk>
References: <1101237725.27848.301.camel@knk>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101243252.19785.316.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 23 Nov 2004 15:54:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 14:22, keith wrote:
> After some lock profiling (keeping track of what locks were last used
> and how many cycles were spent waiting) it became quite clean the the
> avc_lock was to blame.  The avc_lock is a SELinux lock.

Thanks to work by Kaigai Kohei of NEC, the global avc spinlock has been
replaced by an RCU-based scheme.  Those changes are in the -mm patches
(e.g. 2.6.10-rc2-mm3) and will hopefully go upstream after 2.6.10 is
released.  There is also ongoing work on baseline performance.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

