Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVAGP1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVAGP1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVAGP1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:27:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54169 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261457AbVAGP0u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:26:50 -0500
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@epoch.ncsc.mil>, serue@us.ibm.com
MIME-Version: 1.0
Subject: Re: [PATCH] Trusted Path Execution LSM 0.2 (20050107)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF0658EFBB.1401867A-ON87256F82.00549EAD-86256F82.0054D6B5@us.ibm.com>
From: Niki Rahimi <narahimi@us.ibm.com>
Date: Fri, 7 Jan 2005 09:26:41 -0600
X-MIMETrack: Serialize by Router on D03NM690/03/M/IBM(Release 6.53HF56 | October 29, 2004) at
 01/07/2005 08:26:42,
	Serialize complete at 01/07/2005 08:26:42
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very cool. I'm glad to see the interest in my old module. I was hoping to 
make changes but
am now working in Linux support here at IBM, so my time will now focus on 
customers using
Linux. Best wishes with the code! 
Community acceptance, anyone??

Niki A. Rahimi
IBM Premium Services Advanced Support
narahimi@us.ibm.com
 




Lorenzo Hernández García-Hierro <lorenzo@gnu.org>
01/07/2005 03:09 AM
 
        To:     linux-kernel@vger.kernel.org
        cc:     Niki Rahimi/Austin/IBM@IBMUS, Chris Wright 
<chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>, 
serue@us.ltcfwd.linux.ibm.com
        Subject:        [PATCH] Trusted Path Execution LSM 0.2 (20050107)


Hi,

As Chris Wright suggested, the old limitations of the module are not
existing anymore, and the protection hooks are now based on memory
mappings of executables, which means, you can't bypass it by using the
old ld-linux shared library wrapping trick.

Also, many fixes for the module memory use and management, that also
prevent a possible overflowing in read functions of acl management code,
reported by Brad Spengler (a.k.a. spender) when we were revising it
yesterday night.

Also Seth Arnold helped me with some fixes and recommendations.
Anyway, feel free to try to mess it up, i would appreciate any
information about possible vulnerabilities, unexpected behaviors,
stinking buffers...whatever else ;)
Those who have contributed to this little project are listed in the
tpe.c source file.

The patch is attached, but i encourage to check out the
http://selinux.tuxedo-es.org/tpe-lsm/ site, as there you can find two
regression tests, one to try to bypass the engine and the other one for
trigger a basic overflow in the acl read functions (results can be found
at http://selinux.tuxedo-es.org/tpe-lsm/rtest2-log.txt).

The current limitations are described in the tpe-lsm.txt file,
inside ./Documentation/ and a few examples can be found at
http://selinux.tuxedo-es.org/tpe-lsm/0.2-TPE-LSM-Demonstration.txt )

Now i think it could have a chance for mainline inclusion.

Cheers,
--
Lorenzo Hernández García-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager



#### tpe-20050107.patch has been removed from this note on January 07, 
2005 by Niki Rahimi
#### signature.asc has been removed from this note on January 07, 2005 by 
Niki Rahimi

