Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVALRsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVALRsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 12:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVALRsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 12:48:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:22409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbVALRsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 12:48:09 -0500
Date: Wed, 12 Jan 2005 09:48:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: thoughts on kernel security issues
Message-ID: <20050112094807.K24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This same discussion is taking place in a few forums.  Are you opposed to
creating a security contact point for the kernel for people to contact
with potential security issues?  This is standard operating procedure
for many projects and complies with RFPolicy.

http://www.wiretrip.net/rfp/policy.html

Right now most things come in via 1) lkml, 2) maintainers, 3) vendor-sec.
It would be nice to have a more centralized place for all of this
information to help track it, make sure things don't fall through
the cracks, and make sure of timely fix and disclosure.

In addition, I think it's worth considering keeping the current stable
kernel version moving forward (point releases ala 2.6.x.y) for critical
(mostly security) bugs.  If nothing else, I can provide a subset of -ac
patches that are only that.

I volunteer to help with _all_ of the above.  It's what I'm here for.
Use me, abuse me ;-)

thanks,
-chris

===== MAINTAINERS 1.269 vs edited =====
--- 1.269/MAINTAINERS	2005-01-10 17:29:35 -08:00
+++ edited/MAINTAINERS	2005-01-11 13:29:23 -08:00
@@ -1959,6 +1959,11 @@ M:	christer@weinigel.se
 W:	http://www.weinigel.se
 S:	Supported
 
+SECURITY CONTACT
+P:	Security Officers
+M:	kernel-security@{vger.kernel.org, osdl.org, wherever}
+S:	Supported
+
 SELINUX SECURITY MODULE
 P:	Stephen Smalley
 M:	sds@epoch.ncsc.mil
===== REPORTING-BUGS 1.2 vs edited =====
--- 1.2/REPORTING-BUGS	2002-02-04 23:39:13 -08:00
+++ edited/REPORTING-BUGS	2005-01-10 15:35:10 -08:00
@@ -16,6 +16,9 @@ code relevant to what you were doing. If
 describe how to recreate it. That is worth even more than the oops itself.
 The list of maintainers is in the MAINTAINERS file in this directory.
 
+      If it is a security bug, please copy the Security Contact listed
+in the MAINTAINERS file.  They can help coordinate bugfix and disclosure.
+
       If you are totally stumped as to whom to send the report, send it to
 linux-kernel@vger.kernel.org. (For more information on the linux-kernel
 mailing list see http://www.tux.org/lkml/).
