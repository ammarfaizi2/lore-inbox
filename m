Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTDIDtV (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 23:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbTDIDtV (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 23:49:21 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:33443 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262700AbTDIDtV (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 23:49:21 -0400
Date: Tue, 8 Apr 2003 23:57:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: How can I simulate disk failure on 2.4?
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304090000_MC3-1-339D-2D93@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I need some kind of way to fail a single disk partition (hdg8) while the
system is running, then reenable it.  It doesn't have to be general-purpose
and
I don't mind doing ugly hacks to the disk code to make it happen.

  I was thinking of putting a flag in /proc somewhere, along with some code
in generic_make_request like this:

  if (proc_fail_the_disk && bh->b_rdev == the_disk)
    do_something_to_the_request;

 What field could I change in the request that would make it fail without
causing too many side effects?  (I suppose I'd learn a lot by
just picking a likely field and whacking it, but I'm not sure I want to
try and debug the mess.)

 Is this even the right approach at all?


--
 Chuck
