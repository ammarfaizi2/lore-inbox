Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312806AbSCVTTA>; Fri, 22 Mar 2002 14:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312809AbSCVTSv>; Fri, 22 Mar 2002 14:18:51 -0500
Received: from scfdns02.sc.intel.com ([143.183.152.26]:10460 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S312806AbSCVTSe>; Fri, 22 Mar 2002 14:18:34 -0500
Message-Id: <200203221917.g2MJH1701345@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: vamsi@in.ibm.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Date: Fri, 22 Mar 2002 11:19:51 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Daniel Jacobowitz <dan@debian.org>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <200203201912.g2KJC2W24374@unix-os.sc.intel.com> <20020321153320.A1356@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 March 2002 05:03 am, Vamsi Krishna S . wrote:
> Mark,
>
> Does moving the down_write() to be after the registers of all
> threads are collected help? (This patch on top of our previous
> one)

Yes, moving the down_write to after the grabbing of the registers fixes the 
semi lock ups.  

I need to move my Big Sur to RH7.2 to continue my validation.  Its running 
the 7.1 libs and gdb / libpthreads.so aren't as happy at debug time as they 
are for 7.2 on ia32.

Thanks.

--mgross
