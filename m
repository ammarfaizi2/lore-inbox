Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTJASv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJASv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:51:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:13540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbTJASvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:51:54 -0400
Date: Wed, 1 Oct 2003 11:51:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: riel@redhat.com
Cc: torvalds@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: sys_vserver
Message-ID: <20031001115127.A14425@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm surprised to see this merged, even as a place holder.  Primarily
because the same approach was soundly rejected for LSM and sys_security.

  For 2.6 I'd like to do things right.  At the moment the vserver patch
  has sys_new_s_context and sys_set_ipv4root calls, but since we'll
  probably end up getting an ipv6 call too and people are planning future
  functionality, I guess it would be more appropriate to multiplex these
  through one sys_vserver patch, in the same way sys_ipc works.

Multiplexing, future functionality, etc...this reasoning was shot down
before.   The preferred method was to have well-typed interfaces that 
are simple and not overloaded.  Any chance some of these needs could be
met with existing infrastructure in 2.6?  For example, similar to the
sys_new_s_context issue was resolved for LSM with the /proc/pid/attr/
interface, could this be reused?

I'm not trying to instigate a flame, just understand where this is
going.  Sorry if I missed the discussion already.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
