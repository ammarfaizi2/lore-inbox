Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTDQO73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTDQO72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:59:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5319
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261572AbTDQO7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:59:24 -0400
Subject: Re: Help with virus/hackers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: joe briggs <jbriggs@briggsmedia.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0304170932490.15993@chaos>
References: <200304171015.13474.jbriggs@briggsmedia.com>
	 <Pine.LNX.4.53.0304170932490.15993@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050588755.31412.74.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 15:12:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 14:55, Richard B. Johnson wrote:
> (2) Boot with init=/bin/bash

Doesnt help you
> (5)  Examine /etc/inetd.conf (if one exists). If you see an
>      unusual entry near the end, you have been 'rooted'. Newer
>      systems use xinetd and won't get invaded this way.
Wrong. Old xinetd < 2.3.10 has remote root exploits and real
ones circulate
> (6)  Check /etc/passwd for a strange account.
Rootkits patch other stuff
> (7)  Check /bin/login for a new file-date.
> (8)  Check /usr/sbin/sendmail for a new file-date.
>      Check /usr/sbin/inetd      ""
>      Check /usr/sbin/xinetd     ""
>      Check /usr/sbin/syslogd    ""
>      Check /usr/sbin/klogd      ""
>      Check /usr/sbin/in.*       ""

Rootkits know about avoiding this

> If none of these have recent writes, just change the password on
> the root account and be happy. You just has some file-system
> corruption and you can fix up /etc/DIR_COLORS (for your color-ls
> problem) and fix /etc/profile or /root/.bashrc, /root/.profile
> to fix the bad environment variables created by these scripts.

Never do this. You don't know what else has changed on the system. You
should always (barring odd exceptions) do a full reinstall. Also clean
user executable files if neccessary (roots .login is often archived and
people rerun exploits from it...)

See the cert documents on recovering from an attack

