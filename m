Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281675AbRKUOhs>; Wed, 21 Nov 2001 09:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKUOhh>; Wed, 21 Nov 2001 09:37:37 -0500
Received: from web13303.mail.yahoo.com ([216.136.175.39]:57357 "HELO
	web13303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281255AbRKUOh1>; Wed, 21 Nov 2001 09:37:27 -0500
Message-ID: <20011121143726.16204.qmail@web13303.mail.yahoo.com>
Date: Wed, 21 Nov 2001 06:37:26 -0800 (PST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Re: copy to suer space
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick LeRoy <nleroy@cs.wisc.edu> wrote:

 > Linux executables are "demand paged".  What this means is that they are

 > loaded as they are "page faulted" in.  If low on memory, the kernel 
 > may, at it's discression, discard text pages at any time.  When a 
 > discarded page is referenced, a page fault occurs, and the page is re-
 > loaded from the executable.  They are *never* written out to swap 
 > space.  The kernel fully expects the text file and the text memory 
 > pages to not be modified during execution.

Clean pages are never written to swap space. If the page is dirty, it's
just another data page. If it were otherwise, non-PIC shared libraries
that require fixups from the dynamic linker would not work.

Regards
  Joerg


=====
-- 
Regards
       Joerg


__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
