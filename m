Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269302AbUIHSwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269302AbUIHSwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269303AbUIHSwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:52:32 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:20242 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269302AbUIHSwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:52:17 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>,
       linux-kernel@vger.kernel.org
Subject: Re: proc stalls
Date: Wed, 8 Sep 2004 21:52:37 +0300
User-Agent: KMail/1.5.4
References: <20040908054101.GR2966@washoe.rutgers.edu> <20040908141848.GB21729@washoe.rutgers.edu> <20040908105650.398e951a.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <20040908105650.398e951a.Tommy.Reynolds@MegaCoder.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409082152.37022.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 18:56, Tommy Reynolds wrote:
> Uttered Yaroslav Halchenko <yoh@psychology.rutgers.edu>, spake thus:
> > that problem was linked to the fact that nfs-mounted directory became
> > unavailable...
> > Any ideas on how to further debug this situation to avoid future
> > problems?
>
> This is the required behavior for "hard" NFS mounts.  NFS doesn't
> deal with servers that drop off-line very well.
>
> Perhaps you should use the "soft" and/or the "timeo=N" value.  A
> "soft" mount will not cause your client to hang if the server goes
> away.  Unfortunately, this also has implications for application
> program's ideas about file integrity, but there you go.

Think about some very important work being run on NFS-mounted file,
and server is brought down while you're at lunch. I much prefer
client to hang forever (i.e., no 'soft' option!), waiting for admin
to take action.

I use 'hard,intr' so admin can kill 'hung' processed if (s)he wants to.
--
vda

