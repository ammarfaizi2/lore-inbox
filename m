Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWGKXLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWGKXLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWGKXLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:11:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17282 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751346AbWGKXLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:11:21 -0400
Date: Tue, 11 Jul 2006 19:10:14 -0400
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1: drivers/ide/pci/jmicron.c warning
Message-ID: <20060711231014.GA30186@devserv.devel.redhat.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060711125258.GN13938@stusta.de> <20060711140257.GA6820@devserv.devel.redhat.com> <20060711221045.GC13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711221045.GC13938@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 12:10:45AM +0200, Adrian Bunk wrote:
> I'm not a C expert myself, so I asked a gcc developer on irc.
> 
> The problem is that C allows you to assign other values than the ones 
> listed in the enum to the variable.

Its still a gcc bug in that case because you can show by static analysis
that no value is assigned into that array which isn't a member of the enum
and also that nobody takes the address of the object in question...

[Ok its a harder one]

I'd say that gcc warning in the case that all the enum values are enumerated
and have returns is a broken warning irrespective of that so I won't "fix" it
because it isn't broken. Its just like various other bogus gcc warnings


Alan

