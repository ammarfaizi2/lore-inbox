Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWGSFeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWGSFeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 01:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWGSFeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 01:34:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53195 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932505AbWGSFeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 01:34:21 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andi Kleen" <ak@suse.de>
Subject: Re: [patch] i386: show_registers(): try harder to print failing code 
In-reply-to: Your message of "Wed, 19 Jul 2006 00:12:32 +0200."
             <9a8748490607181512t11e9970eu1a7aa1ad1644ec54@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Jul 2006 15:33:41 +1000
Message-ID: <13471.1153287221@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" (on Wed, 19 Jul 2006 00:12:32 +0200) wrote:
>On 18/07/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
>> show_registers() tries to dump failing code starting 43 bytes
>> before the offending instruction, but this address can be bad,
>> for example in a device driver where the failing instruction is
>> less than 43 bytes from the start of the driver's code.  When that
>> happens, try to dump code starting at the failing instruction
>> instead of printing no code at all.
>>
>Shouldn't the kernel be printing some info noting that this fallback
>is in use then? Or will that be completely obvious and I'm just not
>able to see that?

The instruction at the EIP is bracketed, which makes it obvious if you
got any preceding instructions or not.

