Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbSJQFDC>; Thu, 17 Oct 2002 01:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbSJQFDB>; Thu, 17 Oct 2002 01:03:01 -0400
Received: from citi.umich.edu ([141.211.92.141]:17763 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S261796AbSJQFDB>;
	Thu, 17 Oct 2002 01:03:01 -0400
Date: Thu, 17 Oct 2002 01:08:53 -0400
From: Niels Provos <provos@citi.umich.edu>
To: Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>
Cc: marius@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
Message-ID: <20021017050853.GE1704@citi.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am eager to be able to sandbox my processes on a system without the
>help of suid-root programs (as I prefer to have none of these on my
>system).

>Would it be reasonable to allow non-root processes to chroot(), if the
>chroot syscall also changed the cwd for non-root processes?
You might want to look into systrace, see

  http://www.citi.umich.edu/u/provos/systrace/

Sandboxing your own applications does not require special privileges.
Policy generation is intuitive and interactive.  Thats means you can
generate your policies on the fly without complete knowledge of the
exact code paths an application takes.  (I run all my 3rd-party
software and most system daemons under systrace)

Policy violations are reported and can be resolved directly in
interactive mode.

To avoid setuid-root programs, systrace supports Privilege Elevation.

This is a novel feature that allows you to run an application without
special privileges.  The policy can momentarily elevate the privileges
of the application, for example to bind a reserved port or to create a
raw socket.  Basically, it allows as fine grained capabilities as
possible.

The Linux port is basically finished and should appear on the web page
in the next couple days.

Niels.
