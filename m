Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWDEBXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWDEBXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWDEBXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:23:51 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:33884 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751051AbWDEBXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:23:50 -0400
In-Reply-To: <20060405102837.66b44c43.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org> <20060405102837.66b44c43.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
X-Gpgmail-State: !signed
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1E1C6A02-5C4D-4A3A-8483-8D5E2773680B@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Tue, 4 Apr 2006 20:23:23 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 4, 2006, at 7:28 PM, Stephen Rothwell wrote:

> On Tue, 4 Apr 2006 16:14:04 -0500 (CDT) Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> Please pull from 'for_paulus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
>>
>> to receive the following updates:
>>
>>  arch/powerpc/configs/mpc85xx_cds_defconfig |  846 ++++++++++++++++ 
>> +++++++++++++
>>  arch/powerpc/kernel/ppc_ksyms.c            |    1
>>  arch/powerpc/platforms/85xx/Kconfig        |    9
>>  arch/powerpc/platforms/85xx/Makefile       |    1
>>  arch/powerpc/platforms/85xx/mpc85xx_cds.c  |  359 ++++++++++++
>>  arch/powerpc/platforms/85xx/mpc85xx_cds.h  |   43 +
>>  arch/ppc/kernel/ppc_ksyms.c                |    1
>>  include/asm-ppc/mpc85xx.h                  |    3
>>  8 files changed, 1262 insertions(+), 1 deletion(-)
>>
>> Andy Fleming:
>>       Add 85xx CDS to arch/powerpc
>
> Could these "add xxx to arch/powerpc" patches please move any relevant
> headers files to include/asm-powerpc as well.  It would be nice if we
> could remove the hack from the powerpc Makefile that include files  
> from
> include/asm-ppc.  i.e. My opinion is that if any ARCH=powerpc build
> requires a file in include/asm-ppc, then that file should be moved to
> include/asm-powerpc.  I am doing a set of patches to that effect.

We need the irq rework before I'd be willing to do this.  The main  
dependancy between asm-ppc and asm-powerpc is the static IRQs we  
currently have.  I'd rather spend time on fixing up the IRQ handling  
to parse the flat dev tree.

- kumar
