Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291665AbSBAKQ6>; Fri, 1 Feb 2002 05:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291668AbSBAKQv>; Fri, 1 Feb 2002 05:16:51 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:7667 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S291664AbSBAKQm>; Fri, 1 Feb 2002 05:16:42 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.42.0202011012590.804-100000@mob.wid> 
In-Reply-To: <Pine.LNX.4.42.0202011012590.804-100000@mob.wid> 
To: Felix Triebel <ernte23@gmx.de>, rgooch@atnf.csiro.au
Cc: linux-isdn@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ISDN security ??? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 10:15:56 +0000
Message-ID: <4278.1012558556@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can anyone clarify the last paragraph?

--- index.html.orig	Fri Feb  1 09:51:46 2002
+++ index.html	Fri Feb  1 10:11:43 2002
@@ -1073,6 +1073,10 @@
 <A HREF="#s8-9">Why do I get unresolved symbols with __bad_ in the name?</A>
 </LI>
 
+<LI>
+<A HREF="#s8-10">Why do I get warnings about md5sum checks failing in the ISDN code?</A>
+</LI>
+
 </OL>
 
 <H4>
@@ -5182,6 +5186,34 @@
 </LI>
 
 </UL>
+</LI>
+
+<LI>
+<A NAME="s8-10"></A><B>Why do I get warnings about md5sum checks failing in the ISDN code?</B>
+<UL>
+
+<LI>
+<FONT COLOR="#0000FF">(DW)</FONT> These are harmless, and you can
+probably ignore them.
+<BR>
+In many countries, any equipment which is connected to the public 
+telephone networks must be tested and approved to ensure it behaves
+correctly. This requirement also extends to the software used to 
+implement the ISDN protocols with passive ISDN cards.
+<BR>
+The HiSax driver has passed these tests and been approved, but any
+modifications to the source mean that the approval process must be
+repeated. The md5sum checks are therefore present to indicate the 
+current approval status of the HiSax driver. An md5sum failure does
+not mean that your kernel download is corrupted; merely that someone
+has changed the source code since the last time it was certified and
+the md5sums of the approved files updated. 
+<BR>
+It's rumoured that the requirement for certification of ISDN software
+is being relaxed in many countries, so this approval process is
+unnecessary. You should check for yourself the status of such rules in
+your country. Certainly, I've never heard of anyone actually getting 
+prosecuted or otherwise reprimanded for using a modified Linux ISDN stack. 
 </LI>
 
 </OL>

--
dwmw2


