Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTBEN2M>; Wed, 5 Feb 2003 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbTBEN2L>; Wed, 5 Feb 2003 08:28:11 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:30173 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S261205AbTBEN2L>;
	Wed, 5 Feb 2003 08:28:11 -0500
Message-Id: <200302051345.IAA05814@moss-shockers.ncsc.mil>
Date: Wed, 5 Feb 2003 08:45:16 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
To: greg@kroah.com, hch@infradead.org
Cc: torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: GPbQfjXG+8q3ccV25NAmww==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> I still don't see the issue of each LSM module having to duplicate the list
> of sysctls beeing addressed.  Coul you please work something out for that
> before sending it for inclusion?

I already responded to this concern in
http://marc.theaimsgroup.com/?l=linux-kernel&m=104316038729345&w=2 and
http://marc.theaimsgroup.com/?l=linux-security-module&m=104316278400987&w=2.
At most, a field might be added to the ctl_table structure so that the kernel
can provide a hint to security modules as to its view of the sensitivity of
a given sysctl variable, but this does not require any change to the sysctl
hook interface.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

