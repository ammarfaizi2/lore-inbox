Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWHLTmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWHLTmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWHLTmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:42:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44434 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964946AbWHLTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:42:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
	<m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
	<m1irl01hex.fsf@ebiederm.dsl.xmission.com>
	<20060811212522.GF18865@redhat.com>
	<m1d5b6zagy.fsf@ebiederm.dsl.xmission.com>
	<20060812152555.GB16068@redhat.com>
Date: Sat, 12 Aug 2006 13:41:30 -0600
In-Reply-To: <20060812152555.GB16068@redhat.com> (Don Zickus's message of
	"Sat, 12 Aug 2006 11:25:55 -0400")
Message-ID: <m1r6zlyc5x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

>> This looks like a different one but looks fairly sane.  
>> 
>> Do you know what code had problems having _PAGE_NX set.
>> What are we doing with early_ioremap the requires execute
>> permissions.  It doesn't sound right that we would need
>> this.
>
> This fix is only needed for a subset of our em64t boxes, so it could be
> just a chipset problem.  Supposedly, if I remember the conversation
> correctly, when the kernel first boots it reserves about 40MB and about 20
> pmds automatically.  After decompression, early_io_remap tries to setup
> all the memory.  The conflict arose when early_io_remap tried to reuse one
> of those pmds.  This caused the system to crash and reboot.  
>
> I'll try to get more info Monday on the specifics.  

Thanks.


Eric
