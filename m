Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135348AbRAGA3S>; Sat, 6 Jan 2001 19:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135373AbRAGA3I>; Sat, 6 Jan 2001 19:29:08 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:11015 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135348AbRAGA2s>;
	Sat, 6 Jan 2001 19:28:48 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: georgek@netwrx1.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Module compile error 
In-Reply-To: Your message of "Sat, 06 Jan 2001 10:51:53 MDT."
             <f8je5tcv8fudipcjcfib41lacger7it6dv@4ax.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Jan 2001 11:28:41 +1100
Message-ID: <28137.978827321@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2001 10:51:53 -0600, 
George R. Kasica <georgek@netwrx1.com> wrote:
>Keith Owens wrote
>>You have a broken modules.conf that tells depmod to scan _all_ of
>>/lib/modules or you have an old version of modules or you have some
>>weird symlinks in /lib/modules.  It looks like you have some dangling
>>symlinks, although I cannot be certain about that.
>
>Here it is....what do I need to fix on it:
>>path[usb]=/lib/modules/`uname -r`/`uname -v`
>>path[usb]=/lib/modules/`uname -r`
>>path[usb]=/lib/modules/
>>path[usb]=/lib/modules/default

path[usb]=/lib/modules/ is the real killer, you scan all of
/lib/modules and pick up modules for every kernel.  Modutils 2.4 scans
all of /lib/modules/`uname -r` and its subdirectories by default.  You
do not need any path statements unless you have modules that are not
stored in the default path or its subdirectories.  IOW, remove all path
statements unless you are doing something really unusual.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
