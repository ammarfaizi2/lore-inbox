Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263584AbUJ3AwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUJ3AwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbUJ3Atw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:49:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53421 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263605AbUJ3Am4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:42:56 -0400
Subject: Re: 2.6.9 kernel oops with openais
From: Lee Revell <rlrevell@joe-job.com>
To: sdake@mvista.com
Cc: Chris Wright <chrisw@osdl.org>, Mark Haverkamp <markh@osdl.org>,
       Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1099095114.1207.16.camel@persist.az.mvista.com>
References: <1099090282.14581.19.camel@persist.az.mvista.com>
	 <1099091302.13961.42.camel@markh1.pdx.osdl.net>
	 <1099091816.14581.22.camel@persist.az.mvista.com>
	 <20041029163944.H14339@build.pdx.osdl.net>
	 <1099093468.1207.8.camel@persist.az.mvista.com>
	 <20041029164551.U2357@build.pdx.osdl.net>
	 <1099094226.1207.13.camel@persist.az.mvista.com>
	 <20041029170129.W2357@build.pdx.osdl.net>
	 <1099095114.1207.16.camel@persist.az.mvista.com>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 20:42:49 -0400
Message-Id: <1099096970.1579.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 17:11 -0700, Steven Dake wrote:
> What would be preferrable instead of dropping UID when privleged
> services are needed?  more specifically I need
>     * CAP_NET_RAW (bindtodevice)
>      * CAP_SYS_NICE (setscheduler)
>      * CAP_IPC_LOCK (mlockall)
> 
> I had thought about adding the correct code to get these capabilities
> but it still requires a start-from-uid0 environment

Not sure about #1, but Jack (http://jackit.sf.net) needed #2 and #3 and
the realtime LSM was developed as a result.  See the LKML thread of the
same name.

HTH,

Lee

