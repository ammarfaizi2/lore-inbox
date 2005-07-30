Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVG3Ap4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVG3Ap4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVG3An3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:43:29 -0400
Received: from fmr22.intel.com ([143.183.121.14]:28584 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262845AbVG3Alr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:41:47 -0400
Date: Fri, 29 Jul 2005 17:41:38 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces
Message-ID: <20050729174138.A20681@unix-os.sc.intel.com>
References: <20050729162006.GA18866@janus> <20050729170319.23f24a01.akpm@osdl.org> <m17jf9gn1k.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m17jf9gn1k.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Fri, Jul 29, 2005 at 06:22:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 06:22:47PM -0600, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Frank van Maarseveen <frankvm@frankvm.com> wrote:
> >>
> >> 2.6.13-rc4 does not recognize the second CPU of a 3GHz HT P4:
> >
> > OK, we seem to have broken your APIC code.
> 
> There is a big difference here in that one kernel is using
> the ACPI MADT tables and the other kernel is using the MP table.
> 
> I suspect the MP table on your system is incomplete while 
> your ACPI MADT does specify both logical cpus. 

MPS tables will list only physical packages. ACPI MADT tables will list
all the logical CPUs.

Frank, Please enable ACPI in your config and check if it helps.

thanks,
suresh
