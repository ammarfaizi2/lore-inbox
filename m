Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262152AbSJQUfB>; Thu, 17 Oct 2002 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbSJQUfB>; Thu, 17 Oct 2002 16:35:01 -0400
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:40208
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id <S262152AbSJQUfA>; Thu, 17 Oct 2002 16:35:00 -0400
Date: Thu, 17 Oct 2002 13:43:17 -0700
From: Neil Schemenauer <nas@python.ca>
To: swan@shockfrosted.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
Message-ID: <20021017204317.GA4286@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See my "capwrap" module:

    http://arctrix.com/nas/linux/capwrap.tar.gz

To allow SCHED_FIFO you would need to give the process the CAP_SYS_NICE
capability.  CAP_SYS_NICE is bit 23 (800000 in hex).  Create a text file
with the following line and make it root suid:

    &/usr/bin/someprogram 800000

If the capwrap module is loaded the kernel will recognize the file as a
"capability wrapper" and grant the specified capabilities to the
executable while running with the uid of the current user.

The capwrap module isn't fancy but is works and is simple.  It doesn't
require any special filesystem.  Since I'm no kernel hacker I don't know
if it's suitable for inclusion in the main tree.  I would appreciate any
comments people have regarding it.

  Neil
