Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267397AbTACFaU>; Fri, 3 Jan 2003 00:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbTACFaT>; Fri, 3 Jan 2003 00:30:19 -0500
Received: from fmr05.intel.com ([134.134.136.6]:65216 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267397AbTACFaT>; Fri, 3 Jan 2003 00:30:19 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601F1170F@pdsmsx32.pd.intel.com>
From: "Wang, Stanley" <stanley.wang@intel.com>
To: "'Rusty Russell'" <rusty@rustcorp.com.au>
Cc: "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: RE: Kernel module version support. 
Date: Fri, 3 Jan 2003 13:36:19 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty
Thanks for your rapid responding.

And as you are the maintainer of kernel module support, I would like to know
how
you think about export some APIs for geting a specified module structure's
pointer.
Just like:
struct module *get_module(const char *name)
{
	struct module *mod;
	down(&module_mutex);
	mod = find_module(name);
	up(&module_mutex);
	return mod;
}
EXPORT_SYMBOL_GPL(get_module);

This function will be useful when we use Kprobes to place probes into a
kernel module.
We could get the base address of the module's .text section througn this
module structure's
pointer, hence we could place the kernel probe on any instruction we wanted.
  
Thanks a lot.

Your Sincerely,
Stanley Wang 

SW Engineer, Intel Corporation.
Intel China Software Lab. 
Tel: 021-52574545 ext. 1171 
iNet: 8-752-1171 
 
Opinions expressed are those of the author and do not represent Intel
Corporation
