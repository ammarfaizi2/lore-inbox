Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275334AbTHGOow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275365AbTHGOmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:42:55 -0400
Received: from remt24.cluster1.charter.net ([209.225.8.34]:23786 "EHLO
	remt24.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S275364AbTHGOmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:42:38 -0400
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
From: Jerry Cooperstein <coop@axian.com>
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807013930.A26426@google.com>
References: <20030807013930.A26426@google.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060267356.1604.10.camel@p3.coop.hom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 09:42:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you read the release notes for RH9 you'll see you can adjust what
thread library gets used with the environmental variable
LD_ASSUME_KERNEL.  So for instance you can do:

LD_ASSUME_KERNEL=2.2.5 rpm ....
LD_ASSUME_KERNEL=2.2.5 up2date 

(I've mentioned these two because I've noted these fail when you are
root...)


======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
====================================================================


On Thu, 2003-08-07 at 03:39, Frank Cusack wrote:
> Hi,
> 
> The RH9 kernels have NPTL patches.  Standard 2.4.21 does not.
> I am running a custom kernel without the NPTL stuff.
> 
.....
> 
> So, finally getting to my question, should I even *expect* a non-NPTL
> kernel to work with the RH9 userland?  If not, is there a simple fix
> without going to NPTL, say just rebuilding glibc?  hmm... now that I
> ask it I feel dumb, I do think I would need to rebuild glibc so it
> knows the kernel has LinuxThreads, not NPTL.  OK, if that's true
> are there any other libs I should need to rebuild?
> 
> thanks


