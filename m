Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265902AbRGFDdm>; Thu, 5 Jul 2001 23:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265918AbRGFDdc>; Thu, 5 Jul 2001 23:33:32 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:26731 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S265902AbRGFDdW>;
	Thu, 5 Jul 2001 23:33:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: sendhil kumar <hello_linux@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cleanup_module/delete_module. 
In-Reply-To: Your message of "Thu, 05 Jul 2001 20:14:41 MST."
             <20010706031441.44905.qmail@web14907.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Jul 2001 13:32:57 +1000
Message-ID: <6464.994390377@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001 20:14:41 -0700 (PDT), 
sendhil kumar <hello_linux@yahoo.com> wrote:
>I want to know the difference between the
>cleanup_module and delete_module system call. Can any
>one please clarify my doubt.

insmod inserts the address of cleanup_module() in the module structure
at load time.  When syscall delete_module() is about to remove the
module, it calls the module's clean up routine, if it exists.  So
cleanup_module() is invoked during module deletion to let the module do
any local clean up.

