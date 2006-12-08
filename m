Return-Path: <linux-kernel-owner+w=401wt.eu-S1761206AbWLHVJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761206AbWLHVJs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761214AbWLHVJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:09:48 -0500
Received: from gw.goop.org ([64.81.55.164]:38867 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761206AbWLHVJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:09:47 -0500
Message-ID: <4579D496.6080201@goop.org>
Date: Fri, 08 Dec 2006 13:09:42 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arkadiusz Miskiewicz <arekm@maven.pl>, linux-kernel@vger.kernel.org
Subject: Re: proxy_pda was Re: What was in the x86 merge for .20
References: <200612080401.25746.ak@suse.de> <200612081304.23230.arekm@maven.pl> <4579CC7F.1040203@goop.org> <200612082206.20409.ak@suse.de>
In-Reply-To: <200612082206.20409.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Looking at Arkadiusz' output file it looks like gcc 4.2 decided to CSE the
> address :/
>
> 	movl	$_proxy_pda+8, %edx	#, tmp65
>
> Very sad, but legitimate.
>   

Yes, that was my conclusion too.  Though in this case the code could be
cleaned up by cutting down on the number of uses of "current" - but
that's hardly a general fix.

> The only workaround I can think of would be to define it as a symbol
> (or away in vmlinux.lds.S)

Yes.  I was thinking about setting it in vmlinux.lds to some obviously
bad address so that any access will be highly visible.

> . Or do away with the idea of proxy_pda
> again.
>   

That would be very sad indeed.

    J
