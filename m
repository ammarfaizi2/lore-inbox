Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316915AbSEVKEF>; Wed, 22 May 2002 06:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSEVKEE>; Wed, 22 May 2002 06:04:04 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:13587
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S316915AbSEVKEE> convert rfc822-to-8bit; Wed, 22 May 2002 06:04:04 -0400
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
From: Xavier Bestel <xavier.bestel@free.fr>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <3CEB3F93.7030508@evision-ventures.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.4.99 
Date: 22 May 2002 12:03:03 +0200
Message-Id: <1022061793.28881.29.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 22/05/2002 à 08:49, Martin Dalecki a écrit :
> Oh and please reject the idea of compressing the pages
> you are writing to disk for the following reaons:
> 
> 1. compression is not deterministic in terms of the possible space
> savings, you will still have to provide the required amount of space.
> 
> 2. every compression algorithm has theoretical cases where the
> compression mechanism is actually increasing the space requirements.
> 
> 3. Compressing around 360 Mbytes of data will take quite a lot
> of time.
> 
> 4. Point 3 will make the CPU go high - not nice if the suspend
> happens in case of battery emergency...

Compressing pages will speed up the process, and doing it on the fly
will be more IO-bound than CPU-bound. I think trading some CPU power to
gain HD time isn't so uninteresting.

Concerning point 2, you could always compress by chunks (say 1M) and
take the compressed version only if it's smaller.

	Xav


