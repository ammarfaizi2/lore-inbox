Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286267AbRL0NHk>; Thu, 27 Dec 2001 08:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286268AbRL0NHa>; Thu, 27 Dec 2001 08:07:30 -0500
Received: from vega.ipal.net ([206.97.148.120]:14991 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S286267AbRL0NHP>;
	Thu, 27 Dec 2001 08:07:15 -0500
Date: Thu, 27 Dec 2001 07:07:14 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: what file to put a particular function in?
Message-ID: <20011227070714.A23383@vega.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.17, the show_trace_task() function for sparc32 finally showed up.
The problem was, it was moved from traps.c to process.c.  The confusion
is that in other platforms it is in traps.c, not process.c.  DaveM
mentions in past posting that this is arbitrary.  My question is, just
what is the scope of such arbitrary decisions?  And is there even any
need to keep traps.c and process.c separate if functions can be freely
traded between them?

There is inconsistency.  At least show_trace_task() shows up in some
platforms in one file, and in other platforms in another.  This differs
even in related platforms like sparc32 (it's in process.c) and sparc64
(it's in traps.c).  I believe there needs to be some kind of uniform
consistency between platforms where possible.  Unless some special
constraint exists in a platform, I believe any function should show up
in the same place relative to the specific asm- tree.

I'm sure such changes really would not be wise for the remaining 2.4
sequence.  But what about 2.5?  Could this not be included as a goal in
the 2.5 tree, to get functions located more consistently?

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
