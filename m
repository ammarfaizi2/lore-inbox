Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVAYD7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVAYD7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVAYD7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:59:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36586 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261797AbVAYD7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:59:35 -0500
Date: Mon, 24 Jan 2005 22:59:30 -0500
From: Dave Jones <davej@redhat.com>
To: Len Brown <len.brown@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/29] x86-i8259-shutdown
Message-ID: <20050125035930.GG13394@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Len Brown <len.brown@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
	linux-kernel@vger.kernel.org
References: <x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com> <1106623970.2399.205.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106623970.2399.205.camel@d845pe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:32:50PM -0500, Len Brown wrote:
 > On Wed, 2005-01-19 at 02:31, Eric W. Biederman wrote:
 > > From: Eric W. Biederman <ebiederm@xmission.com>
 > > 
 > > This patch disables interrupt generation from the legacy pic on
 > > reboot.  Now that there is a sys_device class it should not be called
 > > while drivers are still using interrupts.
 > > 
 > > There is a report about this breaking ACPI power off on some systems.
 > > http://bugme.osdl.org/show_bug.cgi?id=4041
 > > However the final comment seems to exhonorate this code.  So until
 > > I get more information I believe that was a false positive.
 > 
 > No, the last comment in the bug report
 > (davej says that there were poweroff problems in FC)
 > does not exhonerate this patch.
 > All it says is that there are additional poweroff bugs out there.

Indeed. Since dropping the kexec bits from the Fedora kernel,
the 'hangs at poweroff' bug went away for a lot of folks,
but there still remain some people affected by some other regression.
https://bugzilla.redhat.com/beta/show_bug.cgi?id=acpi_power_off
has the gory details.

		Dave

