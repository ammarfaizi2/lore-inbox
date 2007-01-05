Return-Path: <linux-kernel-owner+w=401wt.eu-S1750867AbXAEXXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbXAEXXA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbXAEXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:23:00 -0500
Received: from gw.goop.org ([64.81.55.164]:52305 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbXAEXW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:22:59 -0500
Message-ID: <459EDDD1.6060208@goop.org>
Date: Fri, 05 Jan 2007 15:22:57 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Rene Herman <rene.herman@gmail.com>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com>
In-Reply-To: <459ABA2F.6070907@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Jeremy? Is it okay to only check the signature word? The checksum will
> generally be done over more than 1 (hw) page... That "presumably"
> there seems a bit flaky? 

Well, in the Xen case, where the pages are simply not mapped, then the
signature simply won't exist.  In other cases, I guess its possible the
signature might exist but the rest of the ROM doesn't, but that won't
happen on normal hardware.

    J

