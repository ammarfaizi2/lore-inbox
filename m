Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVAYIhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVAYIhD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVAYIhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:37:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54994 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261607AbVAYIg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:36:58 -0500
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Jan 2005 01:35:00 -0700
In-Reply-To: <20050125035930.GG13394@redhat.com>
Message-ID: <m1sm4phpor.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Mon, Jan 24, 2005 at 10:32:50PM -0500, Len Brown wrote:
>  > On Wed, 2005-01-19 at 02:31, Eric W. Biederman wrote:
>  > > From: Eric W. Biederman <ebiederm@xmission.com>
>  > > 
>  > > This patch disables interrupt generation from the legacy pic on
>  > > reboot.  Now that there is a sys_device class it should not be called
>  > > while drivers are still using interrupts.
>  > > 
>  > > There is a report about this breaking ACPI power off on some systems.
>  > > http://bugme.osdl.org/show_bug.cgi?id=4041
>  > > However the final comment seems to exhonorate this code.  So until
>  > > I get more information I believe that was a false positive.
>  > 
>  > No, the last comment in the bug report
>  > (davej says that there were poweroff problems in FC)
>  > does not exhonerate this patch.
>  > All it says is that there are additional poweroff bugs out there.

So I will ask again, as I did when Andrew first pointed this in my
direction.  What code path in the kernel could possibly care if we
disable the i8259 after we have disabled all of the other hardware in
the system.

The i8259 is a system device so everything else is shutoff first
(by design).  I have one vague reference that this is a/the
problem but I don't have anything to go on with respect to fixing it.

I don't have a system that reproduces this.

Eric

