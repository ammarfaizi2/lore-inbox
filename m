Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVEKCxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVEKCxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 22:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVEKCxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 22:53:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6126 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261887AbVEKCxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 22:53:31 -0400
Date: Wed, 11 May 2005 08:23:25 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: fastboot@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] kexec+kdump testing with 2.6.12-rc3-mm3
Message-ID: <20050511025325.GA3638@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1115769558.26913.1046.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115769558.26913.1046.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 04:59:18PM -0700, Badari Pulavarty wrote:
> Hi,
> 
> I am using kexec+kdump on 2.6.12-rc3-mm3 and it seems to be working
> fine on my 4-way P-III 8GB RAM machine. I did touch testing with
> kexec+kdump and it worked fine. Then ran heavy IO load and forced
> a panic and I was able to collect the dump. But I am not able to
> analyze the dump to find out if I really got a valid dump or not :(
> 

Copying to LKML.

Gdb can not open a file larger than 2GB. You have got 8GB RAM hence
/proc/vmcore size must be similar. For testing purposes you can boot first
kernel with mem=2G and then take dump and analyze with gdb.


But we need to work on some crash analysis tools like "crash" to be able
to debug larger files. 


> BTW, what architectures kexec+kdump supported ? Does it work on
> x86-64 ?
> 

Kexec has been ported to x86-64 but not kdump.

Thanks
Vivek

