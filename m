Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWACXTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWACXTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWACXTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:19:35 -0500
Received: from web26910.mail.ukl.yahoo.com ([217.146.176.99]:44190 "HELO
	web26910.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964802AbWACXTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:19:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ki4olFFu7XUTgvOYaK6eN0YFPev5v7mDtsDsjTzrLSWNM6yZ6u7QT2kLyk8kwe9xERact74bWCO5aANQE9HrpavXxdiVmvNUC1MAVBhvi6OfFzBI9+UN1FsYLMVFBka6oKOYe5waH7SXg4P5UeA7dW5Lz6LypUO40eX8vQ2cSr4=  ;
Message-ID: <20060103231933.96780.qmail@web26910.mail.ukl.yahoo.com>
Date: Wed, 4 Jan 2006 00:19:33 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Linux 2.6.15
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, very small/few changes in the last week, it seems everybody is off on 
> vacation. All the better.
> 
> The shortlog/diffstat tell the story: a few one-liners, another ipv6 
> deadlock fixed, some sysctl and /proc fixes. 
> 
> Have fun,
>
>		Linus

  It should be quite hard not to have an answer to your E-mail,
 so here his mine...

  I have remade the patch for Gujin kernel.kgz boot file, for 2.6.15
 and 2.6.15-rc5-mm3 and uploaded it to:
http://osdn.dl.sourceforge.net/sourceforge/gujin/linux-gujin-patch.tar.gz
 how to use this file simply documented in:
http://sourceforge.net/project/shownotes.php?release_id=382630&group_id=15465

 The main change from:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112859209607340&w=4
 is a bug (predecrement instead of postdecrement) on the array of IDE
 interfaces found so there is no more any bogus "ide0=0x..." parameter
 passed to the kernel command line.
 Another modification is the documentation of PHYSICAL_START configuration
 parameter to load and execute the kernel at another physical address,
 to change that parameter you need to enable
  General setup  --->  Configure standard kernel features (for small
systems)
 and you have the address in:
  Processor type and features  --->  Physical address where the kernel is
loaded 
 Gujin can load those files starting at any address, and you can check
 in /proc/zoneinfo that "Node 0, zone DMA" is nearly completely free
 when loaded and run at 16 Mb (i.e. 0x1000000) - but I know that some
 configuration still have problem at this address - but do not know
 why.
 Other changes are the removal of most '//' comments and replacement
 of some inline constants with '#define'.

 If this patch would better go in -mm tree, then a cumulative patch
 is included in the sourceforge linux-gujin-patch.tar.gz ; if you
 think that this patch shall be around for a longer time, then I will
 try to keep this sourceforge location up to date - and just send
 a reminder times to times to the list.
 I would enjoy to read any comment you may have on Gujin.
 
 Have fun,
 Etienne.


	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
