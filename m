Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUGXIXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUGXIXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 04:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268369AbUGXIXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 04:23:49 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:16018 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268368AbUGXIXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 04:23:48 -0400
Date: Sat, 24 Jul 2004 01:23:46 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Robert Love <rml@ximian.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: [patch] kernel events layer, updated
Message-ID: <20040724082346.GA22103@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1090604517.13415.0.camel@lucy> <20040723200335.521fe42a.akpm@osdl.org> <1090638679.2296.9.camel@localhost> <20040724075852.GA21299@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040724075852.GA21299@plexity.net>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 24 2004, at 00:58, Deepak Saxena was caught saying:
> The kernel should use an object name that is unique in the context 
> of the kernel (hence my suggestion to use sysfs path, but perhaps there
> is something else?) and D-BUS should generate the appropriate object 
> name that it expects.  The kernel is never going to send messages for 

Ermm..need sleep. What I meant is that D-BUS (kdbusd really) should
take care of generating the object name expected by D-BUS clients
from the kernel object name.  Looking at the kbdusd source, it expects
the kernel to provide a D-BUS object name it can stuff directly into
the dbus_message_new_signal() call.  This means forcing a specific 
kevent-handling mechanism's implementation on the kernel.  I don't think 
that's what we want to do as the sending of events and how those events 
happen to be parsed and handled in userspace should be kept separate. 

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
