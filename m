Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRDYUH1>; Wed, 25 Apr 2001 16:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRDYUHR>; Wed, 25 Apr 2001 16:07:17 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:2779 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S131498AbRDYUHF>; Wed, 25 Apr 2001 16:07:05 -0400
Message-ID: <3AE72EB5.8E521240@kegel.com>
Date: Wed, 25 Apr 2001 13:08:21 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: tim@tjansen.de, linux-kernel@vger.kernel.org,
        "lsb-discuss@lists.linuxbase.org" <lsb-discuss@lists.linuxbase.org>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <200104251937.OAA27702@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> Personally, I think
>         proc_printf(fragment, "%d %d",get_portnum(usbdev), usbdev->maxchild);
> (or the string "dddd ddd" with d representing a digit)
> 
> is shorter (and faster) to parse with
>         fscanf(input,"%d %d",&usbdev,&maxchild);
> 
> Than it would be to try parsing
>         <usb:topology port="ddddd" portnum="dddd">
> with an XML parser.
> 
> Sorry - XML is good for some things. It is not designed to be a
> interface language between a kernel and user space.
> 
> I am NOT in favor of "one file per value", but structured data needs
> to be written in a reasonable, concise manner. XML is intended for
> communication between disparate systems in an exreemly precise manner
> to allow some self documentation to be included when the communication
> fails.

Agreed.  

But one thing XML provides (potentially) is a DTD that defines meanings and formats.  
IMHO the kernel needs something like this for /proc (though not in DTD format!).

Has anyone ever tried to write a formal syntax for all the entries
in /proc?   We have bits and pieces of /proc documentation in 
/usr/src/linux/Documentation, but nothing you could feed directly 
into a parser generator.  It'd be neat to have a good definition for /proc
in the LSB, and have an LSB conformance test that could look in
/proc and say "Yup, all the entries there conform to the spec and can
be parsed properly."

(http://www.pathname.com/fhs/2.2-beta/fhs-2.2-beta.txt mentions /proc,
but doesn't standardize any of it, except to suggest that /etc/mtab
can be a symbolic link to /proc/mounts.)
- Dan
