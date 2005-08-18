Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVHRCZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVHRCZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVHRCZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:25:59 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:65240 "HELO
	develer.com") by vger.kernel.org with SMTP id S932101AbVHRCZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:25:58 -0400
Message-ID: <4303F1B0.8000706@develer.com>
Date: Thu, 18 Aug 2005 04:25:52 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-4 (X11/20050815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joseph Fannin <jfannin@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>, OpenLDAP-devel@OpenLDAP.org,
       Giovanni Bajo <rasky@develer.com>, Simone Zinanni <simone@develer.com>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4303DB48.8010902@develer.com> <20050818010703.GA13127@nineveh.rivenstone.net>
In-Reply-To: <20050818010703.GA13127@nineveh.rivenstone.net>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:

>    The behavior of sched_yield changed for 2.6.  I suppose the man
> page didn't get updated.

Now I remember reading about that on LWN or maybe KernelTraffic.
Thanks!

>>I also think OpenLDAP is wrong.  First, it should be calling
>>pthread_yield() because slapd is a multithreading process
>>and it just wants to run the other threads.  See:
> 
>     Is it possible that this problem has been noticed and fixed
> already?

The OpenLDAP 2.3.5 source still looks like this.
I've filed a report in OpenLDAP's issue tracker:

 http://www.openldap.org/its/index.cgi/Incoming?id=3950;page=2

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

