Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVEKXzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVEKXzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVEKXzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:55:22 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:51893 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id S261336AbVEKXy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 19:54:26 -0400
X-Scanned: Thu, 12 May 2005 02:53:54 +0300 Nokia Message Protector V1.3.34 2004121512 - RELEASE
Subject: Re: arm: Inconsistent kallsyms data
From: Imre Deak <imre.deak@nokia.com>
To: ext Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
In-Reply-To: <20050511224713.A16229@flint.arm.linux.org.uk>
References: <1115802310.9757.20.camel@mammoth.research.nokia.com>
	 <20050511224713.A16229@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: nokia
Date: Thu, 12 May 2005 02:53:17 +0300
Message-Id: <1115855597.9757.42.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The definition I refered to:

static struct platform_device *devices[] __initdata = {
	NULL,
};

To me however it seems to be irrelevant, since meanwhile I managed to
trigger the error multiple ways by changing something else.

I sent the .tmp_map* files of one failed build to Keith.

--Imre

On Wed, 2005-05-11 at 22:47 +0100, ext Russell King wrote:
> On Wed, May 11, 2005 at 12:05:10PM +0300, Imre Deak wrote:
> > I noticed that the error is triggered by an __initdata definition. It is
> > accessed only from an __init function, so that's ok I think. Removing
> > the __initdata attribute gets rid of the error message.
> 
> This sounds very vague.  Can you show us the code please?
> 
> Note that uninitialised variables with an __initdata marking aren't
> legal.


