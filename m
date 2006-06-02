Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWFBA6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWFBA6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWFBA6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:58:50 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:38221 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750830AbWFBA6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:58:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bzfYZld55jITUEpCJOxjV9TP/DC0uhHvRgU9D6S+gHvYfFLw8deBkfohy/gJbai4hj1ihx1iUdBcj7y9WS47C92kZfZ3+BoFPemHXhwLn9DYimoOeTJwXt91YJ5rQHyWvydDuhF1MqUmP181p7MZrQHEIzzHHSOdlG2q3r5omoY=
Message-ID: <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
Date: Thu, 1 Jun 2006 17:58:48 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
X-Google-Sender-Auth: d1fed6314dda8556
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the kernel that I now have booting is 2.6.17-rc5-mm2 + my
pata_pdc2027x patch + the 3 hotfixes that I saw when I started trying
to build the kernel (i.e. without git-scsi-target-fixup but with the
other 3 that are now present).

During boot of my Debian sarge system, this kernel always gives this
warning at "Starting MTA:"
http://static.flickr.com/47/158326090_35d0129147_b_d.jpg

Then, a minute or two after boot, it usually (well over 50% of the
time, but not quite 100%) gives this oops:
http://static.flickr.com/51/158326091_6a7057834c_b_d.jpg

If it doesn't fail with that oops, it usually tends to fail with other
oopses (I have not managed to capture any of those, but they all seem
to mention network-related stuff). Once, it just froze up without an
oops. The oops I posted happens often enough that it's probably
unjustifiably difficult to try reproducing the other oopses until this
one is fixed or worked around.

I plan to try 2.6.17-rc5-mm1 + mingo's latest lockdep patch for that
kernel + a properly fixed-up pata_pdc2027x, to see whether that kernel
fails the same way; I've built it but I won't have a chance to test it
for another 3-6 hours.
-- 
-Barry K. Nathan <barryn@pobox.com>
