Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312497AbSDJGwH>; Wed, 10 Apr 2002 02:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSDJGwG>; Wed, 10 Apr 2002 02:52:06 -0400
Received: from zok.sgi.com ([204.94.215.101]:25011 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S312497AbSDJGwF>;
	Wed, 10 Apr 2002 02:52:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 and runaway modprobe loop? 
In-Reply-To: Your message of "Tue, 09 Apr 2002 09:17:08 MST."
             <Pine.LNX.4.33L2.0204090912540.22258-100000@dragon.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Apr 2002 16:51:48 +1000
Message-ID: <4002.1018421508@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002 09:17:08 -0700 (PDT), 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>If I build/boot 2.5.7 with 64 GB support (with or without
>high_pte), I get:
>
>Freeing unused kernel memory: 448k freed
>INIT: version 2.78 booting
>kmod: runaway modprobe loop assumed and stopped
>kmod: runaway modprobe loop assumed and stopped
>kmod: runaway modprobe loop assumed and stopped
>kmod: runaway modprobe loop assumed and stopped
>kmod: runaway modprobe loop assumed and stopped
>
>If I build/boot it with 4 GB support, it boots fine.
>
>Fixes, suggestion?

If /var/log/ksymoops exists and is mounted rw when that message is
issued, look at 20020409.log to see what modprobe is asking for.
Otherwise add a printk to kernel/kmod::request_module() to print
module_name.  In either case, work out why it is going recursive.

