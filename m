Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbVIVREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbVIVREq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVIVREq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:04:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45491 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030452AbVIVREp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:04:45 -0400
Message-ID: <4332E329.F5CB90B4@redhat.com>
Date: Thu, 22 Sep 2005 13:00:25 -0400
From: Dave Anderson <anderson@redhat.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-e.57enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: vgoyal@in.ibm.com, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFOtokernel  
 core dumps
References: <20050921065633.GC3780@in.ibm.com>
		<m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com>
		<43317980.D6AEA859@redhat.com>
		<m1d5n1cw89.fsf@ebiederm.dsl.xmission.com>
		<20050922140824.GF3753@in.ibm.com> <m1vf0tawgv.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> Vivek Goyal <vgoyal@in.ibm.com> writes:
>
> > I quickly browsed through "crash" code and looks like it is already doing
> > similiar check (kernel.c, verify_version()). It seems to be retrieving
> > "linux_banner" from core image and also retrieving banner string from vmlinux
> > and trying to match. So if banner information can be directly read from the
> > core image, probably there is no need to export it through notes.
>
> Sounds good.  We still need to define a note for the cpu control
> registers.  Do any of the other crash dump solution capture that
> information right now?
>
> Eric

Certainly not in netdump, diskdump or LKCD...

On the other hand, I can't say I ever really needed it, although
that's not to say it couldn't be valuable for some types of
crashes.

Dave


