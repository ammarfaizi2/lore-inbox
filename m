Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277362AbRJEL7b>; Fri, 5 Oct 2001 07:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277365AbRJEL7W>; Fri, 5 Oct 2001 07:59:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19987 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277362AbRJEL7G>;
	Fri, 5 Oct 2001 07:59:06 -0400
Date: Fri, 5 Oct 2001 08:59:19 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>
Cc: <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: %u-order allocation failed
In-Reply-To: <20011005130722.A6570@main.braxis.co.uk>
Message-ID: <Pine.LNX.4.33L.0110050857080.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Krzysztof Rusocki wrote:

> After simple bash fork bombing (about 200 forks) on my UP Celeron/96MB
> I get quite a lot %u-allocations failed, but only when swap is turned
> off.

> I'm not familiar with LinuxVM.. so... is it normal behaviour ? or (if not)
> what's happening when such messages are printed my kernel ?

This is perfectly normal behaviour:

1) on your system, you have no process limit configured for
   yourself so you can start processes until all resources
   (memory, file descriptors, ...) are used

2) when all processes are used, there really is no way the
   kernel can buy you more hardware on ebay and install it
   on the fly ... all it can do is start failing allocations

On production systems, good admins setup per-user limits for
the various resources so no single user is able to run the
system into the ground.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

