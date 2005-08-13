Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVHMS2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVHMS2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 14:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHMS2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 14:28:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36511 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932245AbVHMS2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 14:28:07 -0400
Date: Sat, 13 Aug 2005 14:27:48 -0400
From: Dave Jones <davej@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: obsolete modparam change busted.
Message-ID: <20050813182748.GG26633@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050808184955.GA18779@redhat.com> <1123560076.13481.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123560076.13481.37.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 02:01:16PM +1000, Rusty Russell wrote:
 > On Mon, 2005-08-08 at 14:49 -0400, Dave Jones wrote:
 > > However this change was broken, and if the modprobe.conf
 > > has trailing whitespace, modules fail to load with the
 > > following helpful message..
 > 
 > Hi Dave,
 > 
 > 	This fix should be preferable, I think.
 > 
 > Name: Ignore trailing whitespace on kernel parameters correctly
 > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>


Hey Rusty,
 This seems to have introduced a different regression :-)

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=165633

We're now munching the end of the boot command line it seems.

		Dave

