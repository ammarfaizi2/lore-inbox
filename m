Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWJPOXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWJPOXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWJPOXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:23:16 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:41167 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1750711AbWJPOXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:23:15 -0400
Message-Id: <4533B249.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 16 Oct 2006 16:24:41 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Jiri Kosina" <jikos@jikos.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: dwarf2 stuck Re: lockdep warning in i2c_transfer() with
	dibx000 DVB - input tree merge plans?
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
 <Pine.LNX.4.64.0610161506570.29022@twin.jikos.cz>
 <4533A5A5.76E4.0078.0@novell.com> <200610161617.51111.ak@suse.de>
In-Reply-To: <200610161617.51111.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes, unfortunately this is another instance of gcc 4.0 generating bad
>> unwind data when optimizing and not accumulating outgoing args.
>> Andi - did you already create a patch implementing Michael's suggestion?
>
>You mean using -maccumulate-outgoing-args ? Not yet.
>
>I guess we can do it unconditionally for all gccs on both i386
>and x86-64, right?

Yes, I concluded this from Michael's description; what I don't know is
whether the option isn't available on very old gcc-s.

Jan
