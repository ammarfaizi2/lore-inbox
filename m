Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbTGOO6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbTGOO6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:58:40 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:43012 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S268410AbTGOO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:58:37 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200307151513.LAA09981@clem.clem-digital.net>
Subject: 2.6.0-test1 and second 3c509
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Tue, 15 Jul 2003 11:13:27 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a reminder, I'm still backing out the 2.5.71 3c509 changes to get
my second 3c509 card. Glad to test.

Quoting viro@parcelfarce.linux.theplanet.co.uk
  > On Sun, Jun 15, 2003 at 09:52:01AM -0700, David S. Miller wrote:
  > >    From: Pete Clements <clem@clem.clem-digital.net>
  > >    Date: Sun, 15 Jun 2003 12:50:25 -0400 (EDT)
  > > 
  > >    >From boot log:
  > >    
  > >    Kernel command line: auto BOOT_IMAGE=Linux ro root=341 ether=9,0x310,4,0x3c509,eth1
  > > 
  > > Yes, that explains why the second card isn't found.
  > > 
  > > The problem is:
  > > 
  > > 1) the we can't assign a name to the device
  > >    until we've registered it with the networking
  > > 
  > > 2) without a name the boot argument lookup doesn't work
  > > 
  > > 3) we have to register the device with the networking only
  > >    after it is initialized
  > > 
  > > Hmmm...
  > 
  > Crap.  AFAICS, the clean solution would be to pass these guys (blah_probe())
  > expected device name.  And let them do allocation, etc., themselves.
  > 
  > Looking into it...
  > 

-- 
Pete Clements 

