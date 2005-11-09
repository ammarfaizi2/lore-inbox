Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbVKIRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVKIRIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKIRIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:08:31 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:51535
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751417AbVKIRI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:08:29 -0500
Message-Id: <43723B57.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 18:09:27 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/39] NLKD - early/late CPU up/down notification
References: <43720DAE.76F0.0078.0@novell.com>  <43720E2E.76F0.0078.0@novell.com>  <43720E72.76F0.0078.0@novell.com>  <43720EAF.76F0.0078.0@novell.com> <20051109164544.GB32068@kroah.com>
In-Reply-To: <20051109164544.GB32068@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Greg KH <greg@kroah.com> 09.11.05 17:45:44 >>>
>On Wed, Nov 09, 2005 at 02:58:55PM +0100, Jan Beulich wrote:
>> A mechanism to allow debuggers to learn about starting/dying CPUs
as
>> early/late as possible. Arch-dependent changes for i386 and x86_64
>> will follow.
>> 
>> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
>> 
>> (actual patch attached)
>
>Ick, but it's in base64 mode, so I can't quote it to say that your

That I already was made aware of. Sorry, this worked a few months ago,
but they managed to break this again.

>#ifdef in the .h file is not needed.  Please fix your email client to
>send patches properly.

It's not needed, sure, but by having it there I just wanted to make
clear that this is something that never can be called from a module
(after all, why should one find out at modpost time (and maybe even miss
the message since there are so many past eventual symbol resolution
warnings) when one can already at compile time.

Jan
