Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSCLW6t>; Tue, 12 Mar 2002 17:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSCLW6l>; Tue, 12 Mar 2002 17:58:41 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:5892
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S286343AbSCLW6X>; Tue, 12 Mar 2002 17:58:23 -0500
Subject: Re: uname reports 'unknown'
From: Shawn Starr <spstarr@sh0n.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <6826.1015902879@kao2.melbourne.sgi.com>
In-Reply-To: <6826.1015902879@kao2.melbourne.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 12 Mar 2002 17:59:53 -0500
Message-Id: <1015973994.303.2.camel@coredump>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps it should display P54C which is my P200 processor type?


On Mon, 2002-03-11 at 22:14, Keith Owens wrote:
> On 11 Mar 2002 20:43:37 -0500, 
> Shawn Starr <spstarr@sh0n.net> wrote:
> >Linux coredump 2.4.19-pre2-ac4-xfs-shawn10 #2 Mon Mar 11 03:36:35 EST
> >2002 i586 unknown
> >
> >
> >what should 'unknown' really be? I've never seen it different on Intel
> >systems.
> 
> 'unknown' is the output from uname -p, host processor type.  That field
> is not supported in the Linux kernel.  uname.c in sh-utils has this
> 
> #if defined (HAVE_SYSINFO) && defined (SI_ARCHITECTURE)
>   if (sysinfo (SI_ARCHITECTURE, processor, sizeof (processor)) == -1)
>     error (1, errno, _("cannot get processor type"));
> #else
>   strcpy (processor, "unknown");
> #endif
> 
> HAVE_SYSINFO is always false in sh-utils and SI_ARCHITECTURE is not
> defined in glibc so you always get unknown.
> 
> 


