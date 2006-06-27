Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWF0WwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWF0WwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWF0WwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:52:16 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:28894 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161212AbWF0WwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:52:15 -0400
Date: Wed, 28 Jun 2006 00:52:13 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ben Greear <greearb@candelatech.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060627225213.GB2612@MAIL.13thfloor.at>
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Lezcano <dlezcano@fr.ibm.com>,
	Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
	clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
	devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
	Alexey Kuznetsov <alexey@sw.ru>
References: <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com> <20060627133849.E13959@castle.nmd.msu.ru> <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com> <20060627160241.GB28984@MAIL.13thfloor.at> <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A1689B.7060809@candelatech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:19:23AM -0700, Ben Greear wrote:
> Eric W. Biederman wrote:
> >Herbert Poetzl <herbert@13thfloor.at> writes:
> >
> >
> >>On Tue, Jun 27, 2006 at 05:52:52AM -0600, Eric W. Biederman wrote:
> >>
> >>>Inside the containers I want all network devices named eth0!
> >>
> >>huh? even if there are two of them? also tun?
> >>
> >>I think you meant, you want to be able to have eth0 in
> >>_more_ than one guest where eth0 in a guest can also
> >>be/use/relate to eth1 on the host, right?
> >
> >
> >Right I want to have an eth0 in each guest where eth0 is
> >it's own network device and need have no relationship to
> >eth0 on the host.
> 
> How does that help anything?  Do you envision programs
> that make special decisions on whether the interface is
> called eth0 v/s eth151?

well, those poor folks who do not have ethernet
devices for networking :)

seriously, what I think Eric meant was that it
might be nice (especially for migration purposes)
to keep the device namespace completely virtualized
and not just isolated ...

I'm fine with that, as long as it does not add
overhead or complicate handling, and as far as I
can tell, it should not do that ...

best,
Herbert

> Ben
> 
> 
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
