Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWF0XnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWF0XnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbWF0XnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:43:25 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:16537 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1422735AbWF0XnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:43:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=sIf+RZyvyNr0N8D4ThIJP69gpfBwEMCmIxvCNtjbxkUtzSrXuw/ts3Ov64kbgdZ3aDOsy9DFPTMOrrN4wlL6tUakEF9Alt14fRTPpLGvvgdzaVH1LqYi5Ldsya2jIjewAW/1XIFvYb0qdWDDI4DzrrJeQKg7l2oHO5B7+1V6ib4=;
Date: Wed, 28 Jun 2006 03:42:10 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       Ben Greear <greearb@candelatech.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060627234210.GA1598@ms2.inr.ac.ru>
References: <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com> <20060627133849.E13959@castle.nmd.msu.ru> <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com> <20060627160241.GB28984@MAIL.13thfloor.at> <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com> <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151449973.24103.51.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It may look weird, but do application really *need* to see eth0 rather
> than eth858354?

Applications do not care, humans do. :-)

What's about applications they just need to see exactly the same device
after migration. Not only name, but f.e. also its ifindex. If you do not
create a separate namespace for netdevices, you will inevitably end up
with some strange hack sort of VPIDs to translate (or to partition) ifindices
or to tell that "ping -I eth858354 xxx" is too coimplicated application
to survive migration.

Alexey
