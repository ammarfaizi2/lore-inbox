Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbTDGKR0 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbTDGKR0 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 06:17:26 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:40643 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263372AbTDGKRZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 06:17:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
Date: Mon, 7 Apr 2003 20:21:16 +1000
User-Agent: KMail/1.5.1
References: <200304071026.47557.schlicht@uni-mannheim.de>
In-Reply-To: <200304071026.47557.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304072021.17080.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003 18:26, Thomas Schlichter wrote:
> Hello,
>
> some days ago some friends and me argued about a feature which seems not to
> be included in current OSs but could improve useability mainly for desktop
> computers.
>
> The idea was about prefetching swapped out pages when some memory is free,
> the CPU is idle and the I/O load is low.
>
> So this should not 'cost' much but behave better on following situation:
> (I think there are even more such situations, this one should just be an
> example)
>
> One is surfing the internet and having some browser windows opened. Now,
> without closing the browser windows, he is playing some game which needs
> pretty much memory so the browsers memory is getting swapped out. After
> finishing gaming he's going to make some coffee and then surfing the
> internet again.
> But even if the computer was IDLE for a time and, as the game was closed
> again, some memory is really FREE, the pages for the browser are swapped in
> just when they are needed and not in advance.
>
> With this feature there should be no performance decrease because only free
> resources would be used, and if pages were swapped in but not be used, they
> stay not dirty and so have not to be written to disk when they are swapped
> out again. But the improvements should be obvious if simply the last swaped
> out pages are swapped in again...

This has been argued before. Why would the last swapped out pages be the best 
to swap in? The vm subsystem has (somehow) decided they're the least likely 
to be used again so why swap them in? Alternatively how would it know which 
to swap in instead?

Con
