Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVC3VqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVC3VqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVC3Vp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:45:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262380AbVC3Vo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:44:59 -0500
Date: Wed, 30 Mar 2005 16:44:55 -0500
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050330214455.GF10159@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[apologies to Andi for getting this twice, I goofed the l-k address
 the first time]

 
 I arrived at the office today to find my workstation had this spew
 in its dmesg buffer..
 
 mm/memory.c:97: bad pmd ffff81004b017438(00000038a5500a88).
 mm/memory.c:97: bad pmd ffff81004b017440(0000000000000003).
 mm/memory.c:97: bad pmd ffff81004b017448(00007ffffffff73b).
 mm/memory.c:97: bad pmd ffff81004b017450(00007ffffffff73c).
 mm/memory.c:97: bad pmd ffff81004b017458(00007ffffffff73d).
 mm/memory.c:97: bad pmd ffff81004b017468(00007ffffffff73e).
 mm/memory.c:97: bad pmd ffff81004b017470(00007ffffffff73f).
 mm/memory.c:97: bad pmd ffff81004b017478(00007ffffffff740).
 mm/memory.c:97: bad pmd ffff81004b017480(00007ffffffff741).
 mm/memory.c:97: bad pmd ffff81004b017488(00007ffffffff742).
 mm/memory.c:97: bad pmd ffff81004b017490(00007ffffffff743).
 mm/memory.c:97: bad pmd ffff81004b017498(00007ffffffff744).
 mm/memory.c:97: bad pmd ffff81004b0174a0(00007ffffffff745).
 mm/memory.c:97: bad pmd ffff81004b0174a8(00007ffffffff746).
 mm/memory.c:97: bad pmd ffff81004b0174b0(00007ffffffff747).
 mm/memory.c:97: bad pmd ffff81004b0174b8(00007ffffffff748).
 mm/memory.c:97: bad pmd ffff81004b0174c0(00007ffffffff749).
 mm/memory.c:97: bad pmd ffff81004b0174c8(00007ffffffff74a).
 mm/memory.c:97: bad pmd ffff81004b0174d0(00007ffffffff74b).
 mm/memory.c:97: bad pmd ffff81004b0174d8(00007ffffffff74c).
 mm/memory.c:97: bad pmd ffff81004b0174e0(00007ffffffff74d).
 mm/memory.c:97: bad pmd ffff81004b0174e8(00007ffffffff74e).
 mm/memory.c:97: bad pmd ffff81004b0174f0(00007ffffffff74f).
 mm/memory.c:97: bad pmd ffff81004b0174f8(00007ffffffff750).
 mm/memory.c:97: bad pmd ffff81004b017500(00007ffffffff751).
 mm/memory.c:97: bad pmd ffff81004b017508(00007ffffffff752).
 mm/memory.c:97: bad pmd ffff81004b017510(00007ffffffff753).
 mm/memory.c:97: bad pmd ffff81004b017518(00007ffffffff754).
 mm/memory.c:97: bad pmd ffff81004b017520(00007ffffffff755).
 mm/memory.c:97: bad pmd ffff81004b017528(00007ffffffff756).
 mm/memory.c:97: bad pmd ffff81004b017530(00007ffffffff757).
 mm/memory.c:97: bad pmd ffff81004b017538(00007ffffffff758).
 mm/memory.c:97: bad pmd ffff81004b017540(00007ffffffff759).
 mm/memory.c:97: bad pmd ffff81004b017548(00007ffffffff75a).
 mm/memory.c:97: bad pmd ffff81004b017550(00007ffffffff75b).
 mm/memory.c:97: bad pmd ffff81004b017558(00007ffffffff75c).
 mm/memory.c:97: bad pmd ffff81004b017560(00007ffffffff75d).
 mm/memory.c:97: bad pmd ffff81004b017568(00007ffffffff75e).
 mm/memory.c:97: bad pmd ffff81004b017570(00007ffffffff75f).
 mm/memory.c:97: bad pmd ffff81004b017578(00007ffffffff760).
 mm/memory.c:97: bad pmd ffff81004b017580(00007ffffffff761).
 mm/memory.c:97: bad pmd ffff81004b017588(00007ffffffff762).
 mm/memory.c:97: bad pmd ffff81004b017590(00007ffffffff763).
 mm/memory.c:97: bad pmd ffff81004b017598(00007ffffffff764).
 mm/memory.c:97: bad pmd ffff81004b0175a0(00007ffffffff765).
 mm/memory.c:97: bad pmd ffff81004b0175a8(00007ffffffff766).
 mm/memory.c:97: bad pmd ffff81004b0175b0(00007ffffffff767).
 mm/memory.c:97: bad pmd ffff81004b0175b8(00007ffffffff768).
 mm/memory.c:97: bad pmd ffff81004b0175c0(00007ffffffff769).
 mm/memory.c:97: bad pmd ffff81004b0175c8(00007ffffffff76a).
 mm/memory.c:97: bad pmd ffff81004b0175d0(00007ffffffff76b).
 mm/memory.c:97: bad pmd ffff81004b0175d8(00007ffffffff76c).
 mm/memory.c:97: bad pmd ffff81004b0175e0(00007ffffffff76d).
 mm/memory.c:97: bad pmd ffff81004b0175e8(00007ffffffff76e).
 mm/memory.c:97: bad pmd ffff81004b0175f0(00007ffffffff76f).
 mm/memory.c:97: bad pmd ffff81004b0175f8(00007ffffffff770).
 mm/memory.c:97: bad pmd ffff81004b017600(00007ffffffff771).
 mm/memory.c:97: bad pmd ffff81004b017608(00007ffffffff772).
 mm/memory.c:97: bad pmd ffff81004b017610(00007ffffffff773).
 mm/memory.c:97: bad pmd ffff81004b017618(00007ffffffff774).
 mm/memory.c:97: bad pmd ffff81004b017628(0000000000000010).
 mm/memory.c:97: bad pmd ffff81004b017630(00000000078bfbff).
 mm/memory.c:97: bad pmd ffff81004b017638(0000000000000006).
 mm/memory.c:97: bad pmd ffff81004b017640(0000000000001000).
 mm/memory.c:97: bad pmd ffff81004b017648(0000000000000011).
 mm/memory.c:97: bad pmd ffff81004b017650(0000000000000064).
 mm/memory.c:97: bad pmd ffff81004b017658(0000000000000003).
 mm/memory.c:97: bad pmd ffff81004b017660(0000000000400040).
 mm/memory.c:97: bad pmd ffff81004b017668(0000000000000004).
 mm/memory.c:97: bad pmd ffff81004b017670(0000000000000038).
 mm/memory.c:97: bad pmd ffff81004b017678(0000000000000005).
 mm/memory.c:97: bad pmd ffff81004b017680(0000000000000008).
 mm/memory.c:97: bad pmd ffff81004b017688(0000000000000007).
 mm/memory.c:97: bad pmd ffff81004b017698(0000000000000008).
 mm/memory.c:97: bad pmd ffff81004b0176a8(0000000000000009).
 mm/memory.c:97: bad pmd ffff81004b0176b0(0000000000403840).
 mm/memory.c:97: bad pmd ffff81004b0176b8(000000000000000b).
 mm/memory.c:97: bad pmd ffff81004b0176c0(00000000000001f4).
 mm/memory.c:97: bad pmd ffff81004b0176c8(000000000000000c).
 mm/memory.c:97: bad pmd ffff81004b0176d0(00000000000001f4).
 mm/memory.c:97: bad pmd ffff81004b0176d8(000000000000000d).
 mm/memory.c:97: bad pmd ffff81004b0176e0(00000000000001f4).
 mm/memory.c:97: bad pmd ffff81004b0176e8(000000000000000e).
 mm/memory.c:97: bad pmd ffff81004b0176f0(00000000000001f4).
 mm/memory.c:97: bad pmd ffff81004b0176f8(0000000000000017).
 mm/memory.c:97: bad pmd ffff81004b017708(000000000000000f).
 mm/memory.c:97: bad pmd ffff81004b017710(00007ffffffff734).
 mm/memory.c:97: bad pmd ffff81004b017730(5f36387800000000).
 mm/memory.c:97: bad pmd ffff81004b017738(0000000000003436).
 
 
I've not done a memtest86 run on this (yet), but I'll be very
surprised if this is bad RAM, especially considering other
folks also seem to have hit the same thing when they moved
to 2.6.11.  (My workstation ran 2.6.9/2.6.10 without incident
previously).

http://lkml.org/lkml/2005/3/11/42 for example lists a similar
dump (though obviously differing addresses).
Googling around reveals a bunch of other similar dumps.
 
 		Dave

