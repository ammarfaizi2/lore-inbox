Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTDHLIX (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTDHLIX (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:08:23 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:64751 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261305AbTDHLIW (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 07:08:22 -0400
Date: Tue, 8 Apr 2003 07:15:45 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.67 -- questions about netfilter config options
Message-ID: <Pine.LNX.4.44.0304080702130.25860-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [while i'm discussing these things on the netfilter mailing
list, i figure at least a few folks here might be helpful.]

  i'm trying to clarify the purpose and interdependence of 
the NF config options, and perhaps document them more clearly
in their associated help screens.  to that end, i'm confused
by the way some options can be selected without other 
options that would seem to be obvious dependencies.
to wit:

1) currently, it's possible to select the single option
   "IP tables support" without any other options *anywhere*
   in that menu.  what value does this have?

   if you look down the submenu for that option, you see
   "Packet filtering", which suggests you can ask for 
   "IP tables support" but still not have any ability to
   set up any filtering rules.  sort of strange.  it seems
   odd that you can select to support limit matches,
   TTL matches, etc., without actually having basic
   "Packet filtering" support built in.  what does this
   mean?

   one possibility is that, according to the help info,
   "IP tables support" is necesasry for masq/NAT.  if
   this is true, it leads into my next question ...

2) currently, it's possible to select "Connection tracking"
   without "IP tables support", even though the latter is
   listed as being essential for masq/NAT as well.

   what is the value of selecting only "Conenction tracking"
   in the entire NF config menu?  that is, what does it allow
   you to do if not masq/NAT?

i guess i'm trying to clarify whether there should be more
dependencies in the underlying config structure, or it not,
what it means to select some of these options but not others.

thoughts?

rday

p.s.  is there a reason that almost all of the options
are listed as "(NEW)" in the config menu?  they weren't
even labelled that way in the 2.4.20 kernel.  how is it
that they're suddenly "NEW" now?

