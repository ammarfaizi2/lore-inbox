Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290869AbSAaDDp>; Wed, 30 Jan 2002 22:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290865AbSAaDDc>; Wed, 30 Jan 2002 22:03:32 -0500
Received: from zok.sgi.com ([204.94.215.101]:48607 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S290864AbSAaDDX>;
	Wed, 30 Jan 2002 22:03:23 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS 
In-Reply-To: Your message of "30 Jan 2002 19:42:14 PDT."
             <m1zo2vb5rt.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 14:03:09 +1100
Message-ID: <8200.1012446189@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2002 19:42:14 -0700, 
ebiederm@xmission.com (Eric W. Biederman) wrote:
>I like the other suggestion of extending the Hot-plug infrastructure.
>In that case I just need to figure out how to logically Hot-unplug all
>the devices in the system.  That may be better than a
>do_exitcalls()...  As it automatically gets the discrimination right. 

In an ideal world, it should be enough to call the module_exit()
functions in reverse order to the module_init(), LIFO.  But check with
the hotplug list, they have done most of the work on this problem.

linux-hotplug-devel@lists.sourceforge.net

