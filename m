Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWJWQVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWJWQVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWJWQVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:21:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751913AbWJWQVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:21:32 -0400
Message-ID: <453CEBFB.9010409@redhat.com>
Date: Mon, 23 Oct 2006 11:21:15 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: time warp on 2.6.18-rt6 (2nd try)
References: <4539158C.2090801@redhat.com> <20061020210821.GA28420@elte.hu>
In-Reply-To: <20061020210821.GA28420@elte.hu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar wrote:
> * Clark Williams <williams@redhat.com> wrote:
> 
>> I'm still seeing the time warp ("It's just a jump to the left!" :))* 
>> being triggered on both my Athlon64x2 (32-bit kernel) and my Athlon64 
>> up box (64-bit kernel). [...]
> 
> that was most likely a false positive - every time settimeofday is done. 
> I've just uploaded -rt7, could you check it whether the time warp 
> messages are gone?
> 
> 	Ingo

I ran pi_stress on both the 32-bit kernel (Athlon64x2) and a 64-bit
kernel (Athlon64 up) and am still getting a time warp bug.

I'm rebuilding now with a bit more debug info turned on and I'm trying
to track down an Intel box that I can try this on to see if somehow I'm
exercising a code path that hasn't been touched much. Hopefully I'll be
able to test on a P3/P4 box this afternoon and can confirm or deny
whether this is AMD specific.

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFPOv6Hyuj/+TTEp0RAo2SAJ4iKMHJeYY8KHkK+cR9DdjW5caZbwCdHE+U
J2N4AuipJwzZJi0n31BXFYE=
=VIvH
-----END PGP SIGNATURE-----
