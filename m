Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270862AbRHNVFN>; Tue, 14 Aug 2001 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270846AbRHNVFD>; Tue, 14 Aug 2001 17:05:03 -0400
Received: from patan.Sun.COM ([192.18.98.43]:16781 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S270845AbRHNVEv>;
	Tue, 14 Aug 2001 17:04:51 -0400
Message-ID: <3B799358.38EF3B72@sun.com>
Date: Tue, 14 Aug 2001 14:08:40 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFC: poll change
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all, I have a request from someone to investigate this.

poll() currently does not allow you to pass more fd's than you have open. 
At first this seems reasonable.  However, I have seen now at least one app
that takes advantage of a behavior found on some poll() implementations (I
don't have the standard available..).

On these systems, you may pass in as many fds as you want, and any
structure with the fd member set to < 0 is ignored.  This allows apps to
save on allocating and re-allocating, or sorting the fd arrays.

What would the feeling be if I implemented this for Linux?

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
