Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSKOOkn>; Fri, 15 Nov 2002 09:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKOOkm>; Fri, 15 Nov 2002 09:40:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12206 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266308AbSKOOkm>; Fri, 15 Nov 2002 09:40:42 -0500
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Tim Hockin <thockin@hockin.org>, Tim Hockin <thockin@sun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD45EEB.4E4F170@digeo.com>
References: <3DD44E39.4703C2DA@digeo.com> from "Andrew Morton" at Nov 14,
	2002 05:30:33 PM <200211150233.gAF2XQv15588@www.hockin.org> 
	<3DD45EEB.4E4F170@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 15:13:35 +0000
Message-Id: <1037373215.19987.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 02:41, Andrew Morton wrote:
> In that case a radix tree _might_ suit.  All you need to put in the
> node is a (void *)1 or (void *)0.  But it won't be very space-efficient
> for really sparse groups.

99.999% of users will have < 16 groups, probably less than 8. If the
system doesn't get that default case as fast and memory efficient as
before the priorities are badly wrong.

