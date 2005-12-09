Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVLITCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVLITCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVLITCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:02:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44417 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932408AbVLITCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:02:45 -0500
Date: Fri, 9 Dec 2005 20:01:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: JANAK DESAI <janak@us.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/5] New system call, unshare
Message-ID: <20051209190137.GA25656@elte.hu>
References: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com> <20051209105502.GA20314@elte.hu> <20051209120244.GL27946@ftp.linux.org.uk> <43999199.70608@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43999199.70608@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* JANAK DESAI <janak@us.ibm.com> wrote:

> To answer Ingo's question, we did look at other flags when I started.  
> However, I wanted to keep the system call simple enough, with atleast 
> namespace unsharing, so it would get accepted. In the original 
> discussion on fsdevel, unsharing of vm was mentioned as useful so I 
> added that in addition to namespace unsharing.

i think the only sane way to do this is to support unsharing for all 
flags. Internally (i.e. in the patch-queue) it can still be structured 
in a finegrained way, but in terms of exposing it to applications, it 
should be an all or nothing solution i think.

	Ingo
