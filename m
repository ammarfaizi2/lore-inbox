Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289388AbSAJK5k>; Thu, 10 Jan 2002 05:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289389AbSAJK5b>; Thu, 10 Jan 2002 05:57:31 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:51172 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289388AbSAJK5K>; Thu, 10 Jan 2002 05:57:10 -0500
Message-ID: <3C3D7383.9F45013@redhat.com>
Date: Thu, 10 Jan 2002 10:57:07 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rainer Keller <Keller@hlrs.de>, linux-kernel@vger.kernel.org
Subject: Re: Small optimizations for UP (sched and prefetch)
In-Reply-To: <3C3D6582.576A3D8D@hlrs.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +#ifndef CONFIG_SMP
> +#define spin_lock_prefetch(x)
> +#else
> +#define spin_lock_prefetch(x) prefetchw(x)
> +#endif
> 

please make it
+#define spin_lock_prefetch(x) do {} while (0)

instead of an empty define...
