Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271440AbTGQL6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271441AbTGQL6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:58:13 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:64750 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S271440AbTGQL5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:57:51 -0400
Subject: Re: 2.6.0-t1-ac2: unable to compile glibc 2.3.2
From: Martin Schlemmer <azarah@gentoo.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030717114548.5f5d506d.martin.zwickel@technotrend.de>
References: <20030717114548.5f5d506d.martin.zwickel@technotrend.de>
Content-Type: text/plain
Organization: 
Message-Id: <1058443940.13515.1533.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 17 Jul 2003 14:12:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 11:45, Martin Zwickel wrote:
> Hi there!
> 
> I just tried to update my glibc to 2.3.2 and saw that glibc can't compile
> because of linux/sysctl.h.
> 
> I added the line "#include <linux/compiler.h>" to sysctl.h.
> (since sysctl needs the __user)
> 
> So someone forgot the line, or did I miss something?
> 

No, you should not use the kernel headers directly - use a sanitized
version (can get one from redhat's kernel-headers package).  Else
just add a '#define __user' before that struct.


Regards,

-- 
Martin Schlemmer


