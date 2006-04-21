Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWDUL5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWDUL5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWDUL5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:57:04 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:30565 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1751306AbWDUL5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:57:00 -0400
X-ME-UUID: 20060421115658399.618357000084@mwinf1307.wanadoo.fr
Date: Fri, 21 Apr 2006 13:55:56 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060421115556.GA14178@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	rth@twiddle.net
References: <20060421095028.GA8818@bigip.bigip.mine.nu> <20060421114149.24F5EDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20060421114149.24F5EDBA1@gherkin.frus.com>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 21, 2006 at 06:41:49AM -0500, Bob Tracy wrote:
> I'll try upgrading from gcc-4.0 to gcc-4.1, and if/when that has no
> effect, I'll go looking for a later binutils in Debian's "unstable"
> tree (I've already had to go to the "testing" tree to get beyond gcc-3
> and binutils-2.15.X).  Report to follow later today.

Ok.

> Item for consideration: what kind of optimization is enabled for your
> test case compile vs. what's being used for the kernel build?  That's
> another variable we need to sort out.  For what it's worth, I do *not*
> have CONFIG_CC_OPTIMIZE_FOR_SIZE enabled: the comment about "watch out
> for broken compilers" was enough to scare me off while we're trying to
> chase this down.

Well I thought of this already and tried my test case without any flags
but -Wall, with -O2 and -Os.  Same result.  I also compiled my test case
with the options used by the kernel (which ATM isn't compiled with -Os),
same thing.

I've attached to this email a tarball of what I use to test the
compiler/binutils.  It's faster than recompiling the whole kernel on
these slow machines!
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

--3MwIy2ne0vdjdPXF
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="strncpy_debug.tar.gz"
Content-Transfer-Encoding: base64

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

--3MwIy2ne0vdjdPXF--

