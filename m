Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRDFXjm>; Fri, 6 Apr 2001 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132459AbRDFXjc>; Fri, 6 Apr 2001 19:39:32 -0400
Received: from nrcvicex1a.hia.nrc.ca ([204.174.103.8]:18437 "EHLO
	nrcvicex1.hia.nrc.ca") by vger.kernel.org with ESMTP
	id <S132434AbRDFXjY>; Fri, 6 Apr 2001 19:39:24 -0400
Message-ID: <3ACE5501.F5F551E4@nrc.ca>
Date: Fri, 06 Apr 2001 16:45:05 -0700
From: Tony Hoffmann <tony.hoffmann@nrc.ca>
Reply-To: tony.hoffmann@nrc.ca
Organization: National Research Council of Canada
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mkinitrd and 2.4.x annoyances
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to upgrade a redhat 6.2 I've come across the following
annoyance.

Changes states that you need mkinitrd 2.9 or better.  No problem. Go to
redhat
site and grab source rpm.  In my case 3.0.5 was the one available. 
Build and
install the package.  Run it. Curse. Turns out that mkinitrd relies on
mktemp
accepting the -d which under 6.2 isn't the case.  And remakeing mktemp
isn't
an option as I'm not about to upgrade to glibc 2.2 just for that.  It
was an
easy enough fix to patch mkinitrd to not rely on the -d flag but still
bloody
annoying.  I can see why they use mktemp -d as they do all the work in
the /tmp
dir so want to avoid potential races in creating the temp directories
but why
use /tmp at all?  It's possible to do everything in the current working,
No?
