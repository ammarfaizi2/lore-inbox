Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131098AbQKACM5>; Tue, 31 Oct 2000 21:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbQKACMq>; Tue, 31 Oct 2000 21:12:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:10512 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131118AbQKACMj>;
	Tue, 31 Oct 2000 21:12:39 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 (LINK ordering) 
In-Reply-To: Your message of "Tue, 31 Oct 2000 17:24:24 -0800."
             <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBE5@orsmsx31.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2000 13:11:30 +1100
Message-ID: <21184.973044690@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 17:24:24 -0800, 
"Dunlap, Randy" <randy.dunlap@intel.com> wrote:
>Is it valid to run depmod like this before
>booting the kernel that has usbcore in-kernel?
>depmod -ae works after I boot that kernel + usbcore.

To run depmod against a new 2.4.0-test10 kernel,
  make modules_install
  depmod -ae -F System.map 2.4.0-test10
Without -F, depmod reads /proc/ksyms which are for the old kernel.
make modules_install runs depmod with those parameters anyway.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
