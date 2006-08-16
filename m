Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWHPG2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWHPG2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWHPG2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:28:30 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:48593 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1750940AbWHPG2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:28:30 -0400
Message-Id: <44E2D737.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 16 Aug 2006 08:28:39 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@muc.de>
Cc: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [PATCH] fix x86 cpuid keys used in alternative_smp()
References: <44E20C5C.76E4.0078.0@novell.com>
 <20060815182145.6dc74c63.ak@muc.de>
In-Reply-To: <20060815182145.6dc74c63.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> By hard-coding the cpuid keys for alternative_smp() rather than using
>> the symbolic constant it turned out that incorrect values were used on
>> both i386 (0x68 instead of 0x69) and x86-64 (0x66 instead of 0x68).
>
>Thanks. Applied.
>
>I wonder if that was the reason why the .fill misassembly the 
>2.16.91.0.5 (10.1) binutils commits (see recent discuss report from
>Rafael) didn't cause crashes on UP machines.  Do you have
>an opinion on that?

That is well possible - I saw the mail, and I also wondered why this
wouldn't result in a broken kernel.

Jan
