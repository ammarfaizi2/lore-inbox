Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVAYGdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVAYGdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVAYGdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:33:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35026 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261842AbVAYGcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:32:47 -0500
To: Dave Jones <davej@redhat.com>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<1106623970.2399.205.camel@d845pe> <20050125035930.GG13394@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Jan 2005 23:30:53 -0700
In-Reply-To: <20050125035930.GG13394@redhat.com>
Message-ID: <m13bwqhvfm.fsf@ebiederm.dsl.xmission.com>
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
> 
> Indeed. Since dropping the kexec bits from the Fedora kernel,
> the 'hangs at poweroff' bug went away for a lot of folks,
> but there still remain some people affected by some other regression.
> https://bugzilla.redhat.com/beta/show_bug.cgi?id=acpi_power_off
> has the gory details.

Ok.  I misunderstood that one then.  I thought a separate fix
had cured the bug.  With the kexec bits remaining.

Eric
