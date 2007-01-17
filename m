Return-Path: <linux-kernel-owner+w=401wt.eu-S932581AbXAQRP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbXAQRP4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 12:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXAQRP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 12:15:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:20773 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581AbXAQRPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 12:15:55 -0500
Message-ID: <45AE5B8A.5040407@sw.ru>
Date: Wed, 17 Jan 2007 20:23:22 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "<Andrew Morton" <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
       minyard@acm.org, rtc-linux@googlegroups.com, clemens@ladisch.de,
       heiko.carstens@de.ibm.com, xfs@oss.sgi.com, linuxppc-dev@ozlabs.org,
       paulus@samba.org, openipmi-developer@lists.sourceforge.net,
       linux-390@vm.marist.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
       codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
       tony.luck@intel.com, vojtech@suse.cz, linux-scsi@vger.kernel.org,
       xfs-masters@oss.sgi.com, linux-ntfs-dev@lists.sourceforge.net,
       netdev@vger.kernel.org, aia21@cantab.net, aharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       mark.fasheh@oracle.com, coda@cs.cmu.edu, lethal@linux-sh.org,
       kurt.hackel@oracle.com, containers@lists.osdl.org, linux390@de.ibm.com,
       philb@gnu.org, andrea@suse.de,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
Subject: Re: [PATCH 33/59] sysctl: s390 move sysctl definitions to sysctl.h
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656572714-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656572714-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDs not sorted in enum. see below.

> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> We need to have the the definition of all top level sysctl
> directories registers in sysctl.h so we don't conflict by
> accident and cause abi problems.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/s390/appldata/appldata.h |    3 +--
>  arch/s390/kernel/debug.c      |    1 -
>  arch/s390/mm/cmm.c            |    4 ----
>  include/linux/sysctl.h        |    7 +++++++
>  4 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/appldata/appldata.h b/arch/s390/appldata/appldata.h
> index 0429481..4069b81 100644
> --- a/arch/s390/appldata/appldata.h
> +++ b/arch/s390/appldata/appldata.h
> @@ -21,8 +21,7 @@
>  #define APPLDATA_RECORD_NET_SUM_ID	0x03	/* must be < 256 !     */
>  #define APPLDATA_RECORD_PROC_ID		0x04
>  
> -#define CTL_APPLDATA 		2120	/* sysctl IDs, must be unique */
> -#define CTL_APPLDATA_TIMER 	2121
> +#define CTL_APPLDATA_TIMER 	2121	/* sysctl IDs, must be unique */
>  #define CTL_APPLDATA_INTERVAL 	2122
>  #define CTL_APPLDATA_MEM	2123
>  #define CTL_APPLDATA_OS		2124
> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index bb57bc0..c81f8e5 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
> @@ -852,7 +852,6 @@ debug_finish_entry(debug_info_t * id, debug_entry_t* active, int level,
>  static int debug_stoppable=1;
>  static int debug_active=1;
>  
> -#define CTL_S390DBF 5677
>  #define CTL_S390DBF_STOPPABLE 5678
>  #define CTL_S390DBF_ACTIVE 5679
>  
> diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
> index 607f50e..df733d5 100644
> --- a/arch/s390/mm/cmm.c
> +++ b/arch/s390/mm/cmm.c
> @@ -256,10 +256,6 @@ cmm_skip_blanks(char *cp, char **endp)
>  }
>  
>  #ifdef CONFIG_CMM_PROC
> -/* These will someday get removed. */
> -#define VM_CMM_PAGES		1111
> -#define VM_CMM_TIMED_PAGES	1112
> -#define VM_CMM_TIMEOUT		1113
>  
>  static struct ctl_table cmm_table[];
>  
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 71c16b4..56d0161 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -73,6 +73,8 @@ enum
>  	CTL_SUNRPC=7249,	/* sunrpc debug */
>  	CTL_PM=9899,		/* frv power management */
>  	CTL_FRV=9898,		/* frv specific sysctls */
> +	CTL_S390DBF=5677,	/* s390 debug */
> +	CTL_APPLDATA=2120,	/* s390 appldata */
<<<< not sorted by ID? imho should be sorted. otherwise can'be unnotied when inserted above.

>  };
>  
>  /* CTL_BUS names: */
> @@ -205,6 +207,11 @@ enum
>  	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
>  	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
>  	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
> +
> +	/* s390 vm cmm sysctls */
> +	VM_CMM_PAGES=1111,
> +	VM_CMM_TIMED_PAGES=1112,
> +	VM_CMM_TIMEOUT=1113,
>  };
>  
>  

