Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTENOZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbTENOZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:25:25 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:4284 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262321AbTENOZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:25:22 -0400
Date: Wed, 14 May 2003 10:35:54 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Stephen Torri <storri@sbcglobal.net>
Cc: <bug-glibc@gnu.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compile error including asm/uaccess.h
In-Reply-To: <1052871028.15836.24.camel@base>
Message-ID: <Pine.LNX.4.33.0305141030000.10993-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> #include <asm/uaccess.h>
>
> int main (){
> 	return 0;
> }


Hi stephen:

<asm/uaccess.h> or for that matter any other kernel related header do
not contain references to other headers they may need, and this is done on
purpose for various reasons least of which is creating faster dependencies
information.

In any event, if your purpose is to use any information usefully from
these, then you should look into an other file in the kernel code that
includes this file and see the headers that are include before it.

Also have a look at the defines that go with compiling this file.

If you are simply verifying the existence of this file in an autoconf
configure type script (which may be the case looking at your example
code).  Then you should write your own test of somesort rather than
resorting to AC_CONFIG_HEADER.

Cheers,

Ahmed.

For more info have a look at www.kernelnewbies.org

