Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbSJQMma>; Thu, 17 Oct 2002 08:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJQMma>; Thu, 17 Oct 2002 08:42:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33291 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261684AbSJQMm3>;
	Thu, 17 Oct 2002 08:42:29 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: non-modversions GPLONLY_ 
In-reply-to: Your message of "Wed, 16 Oct 2002 17:49:18 MST."
             <20021016.174918.125874029.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Oct 2002 22:48:16 +1000
Message-ID: <14683.1034858896@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002 17:49:18 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>If we export the symbol as GPLONLY_dequeue_signal (for example), yet
>don't use modversions to mangle the GPLONLY_ prefix to the symbol for
>what code actually uses to access the symbol, what makes this work?
>
>Is there some magic in newer versions of modutils which does
>this transparently? :-)

modutils 2.4.10 added support for GPLONLY_ symbols, with fixes though
2.4.14 (2001-10-0 to 2002-02-27).  insmod strips the leading "GPLONLY_"
when loading a symbol into the hash table iff the module being loaded
has a GPL license.

