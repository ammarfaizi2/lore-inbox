Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTEMJ0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 05:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTEMJ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 05:26:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37970 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263407AbTEMJ0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 05:26:35 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4 (machine_power_off returning causes problems)
References: <8570000.1052623548@[10.10.2.4]>
	<20030510224421.3347ea78.akpm@digeo.com>
	<8880000.1052624174@[10.10.2.4]>
	<20030510231120.580243be.akpm@digeo.com>
	<12530000.1052664451@[10.10.2.4]>
	<m17k8x72ir.fsf_-_@frodo.biederman.org>
	<19660000.1052710226@[10.10.2.4]> <m11xz45lqk.fsf@frodo.biederman.org>
	<22080000.1052743429@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2003 03:35:59 -0600
In-Reply-To: <22080000.1052743429@[10.10.2.4]>
Message-ID: <m1vfwf429s.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> Well, yes ... but I'm not trying to use kexec, just doing an init 0 ;-)
> That worked fine before. Perhaps you want to take this code out of the
> power down path, and just have it in the reboot path? Seems odd to change
> the power down path if you don't need to.

Fundamental rule of software reliability/simplicity.  Build one basket
and put all of your eggs in it.

I guess I can't possibly imagine why after a system halt anyone
would want random cpus scurrying around.  So this forces the issues
up to the from so they can be examined and fixed.

If the code is wrong from NUMA-Q I would like to get a correct version.
 
Eric
