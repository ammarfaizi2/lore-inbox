Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277074AbRJKXl4>; Thu, 11 Oct 2001 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277073AbRJKXlr>; Thu, 11 Oct 2001 19:41:47 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:21515 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277072AbRJKXlo>;
	Thu, 11 Oct 2001 19:41:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Export objs from an external Makefile? 
In-Reply-To: Your message of "Thu, 11 Oct 2001 09:35:32 MST."
             <20011011093532.K12016@cpe-24-221-152-185.az.sprintbbd.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Oct 2001 09:42:05 +1000
Message-ID: <32224.1002843725@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 09:35:32 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>Hey all.  How do you do the 'export-objs' bits in a kernel module that's
>outside of the kernel?  Thanks..

Compile with -DMODULE -DEXPORT_SYMTAB.  If the kernel has modversions,
add -DMODVERSIONS -include $(HPATH)/linux/modversions.h.  The safest
way is to compile a module in the kernel that exports the objects then
copy the command, substituting the file names.

