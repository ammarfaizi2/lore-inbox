Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbRCVSo6>; Thu, 22 Mar 2001 13:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132148AbRCVSot>; Thu, 22 Mar 2001 13:44:49 -0500
Received: from mons.uio.no ([129.240.130.14]:16626 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S132146AbRCVSod>;
	Thu, 22 Mar 2001 13:44:33 -0500
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org
Subject: Re: PROBLEM: 2.2.18 oops leaves umount hung in disk sleep
In-Reply-To: <E14g8eP-0006k5-00@intech19.enhanced.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Mar 2001 19:43:41 +0100
In-Reply-To: Camm Maguire's message of "Thu, 22 Mar 2001 12:13:29 -0500"
Message-ID: <shs1yrpabky.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Camm Maguire <camm@enhanced.com> writes:

     > 2.2.18 oops leaves umount hung in disk sleep

This is normal behaviour for an Oops ;-)

     >      Unable to handle kernel NULL pointer dereference at
     >      virtual address 00000000
    current-> tss.cr3 = 02872000, %%cr3 = 02872000
     >      *pde = 00000000 Oops: 0000 CPU: 0

     >      intech9# ksymoops <oo.txt

     >      ksymoops 2.3.4 on i586 2.2.18-i586tsc.  Options used -V
     >      (default) -k /proc/ksyms (default) -l /proc/modules
     >      (default) -o /lib/modules/2.2.18-i586tsc/ (default) -m
     >      /boot/System.map-2.2.18-i586tsc (default)

     >      Warning: You did not tell me where to find symbol
     >      information.  I will assume that the log matches the
     >      kernel and modules that are running right now and I'll use
     >      the default options above for symbol resolution.  If the
     >      current kernel and/or modules do not match the log, you
     >      can get more accurate output by telling me the kernel
     >      version and where to find map, modules, ksyms etc.
     >      ksymoops -h explains the options.

     >      Warning (compare_maps): ksyms_base symbol
     >      module_list_R__ver_module_list not found in System.map.
     >      Ignoring ksyms_base entry
    
     >      Unable to handle kernel NULL pointer dereference at
     >      virtual address 00000000 current->tss.cr3 = 02872000,
     >      %%cr3 = 02872000 *pde = 00000000 Oops: 0000 CPU: 0

Do you have the full ksymoops decode available? The above is somewhat
minimal.

Also please could you try to duplicate the problem with a standard
autofs v3 daemon? I'm not sure that the v4 'automount' is quite as
well tested as the v3 daemon (it still seems to be in beta).

Cheers,
  Trond
