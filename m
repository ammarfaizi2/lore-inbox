Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266502AbUF0Bw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUF0Bw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 21:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUF0Bw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 21:52:58 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:22912
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S266502AbUF0Bw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 21:52:57 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Process in D state with USB and swsuspsp
Date: Sat, 26 Jun 2004 20:34:56 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406262031.14464.rob@landley.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realise I did something stupid, but it took a while to figure it out, and 
I'm not going to be the only person to do this.

My laptop has built-in wireless (orinoco_cs), but I used a USB ethernet 
adapter to plug in to the wall for a bit (ohci-hcd and pegasus).

Then I the suspended the thing, unplugged the USB adapter, and packed the 
laptop up.  About twelve hours later, I fire the thing up, run "dhclient" to 
get a wireless connection, but the first thing it tried to touch was the USB 
connection that isn't there anymore.  So it hung, ctrl-c wouldn't kill it, 
and the process is stuck in D state.

Trying to figure out what was going on, I ran dhclient twice more and got two 
more processes stuck in D state.  It took a while to remember that yesterday 
I was using the USB adapter, but today I'm not.

Ordinarily, I don't think the ohci-hcd module is even loaded.  The kernel 
currently thinks it is, but modprobe -r ohci-hcd resulted in yet another 
process in D state...

As I said, I realise that unplugging even a USB adapter with the machine is 
suspended is Not A Good Thing.  But it's likely to be a common thing among 
people who can't figure out after the fact "oh yeah, that's what's going 
wrong"...

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)


