Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbUK0Win@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUK0Win (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUK0Win
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:38:43 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50393 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261355AbUK0Wim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:38:42 -0500
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1101370853.2659.1.camel@laptop.fenrus.org>
References: <1101314988.1714.194.camel@mulgrave>
	 <1101323621.2811.24.camel@laptop.fenrus.org>
	 <1101356864.4007.35.camel@mulgrave> <20041124203349.7982efb7.akpm@osdl.org>
	 <1101370853.2659.1.camel@laptop.fenrus.org>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 17:38:40 -0500
Message-Id: <1101595121.15635.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-25 at 09:20 +0100, Arjan van de Ven wrote:
> HZ=1000 costs you 1% HPC performance, and for slower machines probably more. Also some hw (with slow smm) really doesn't likeit.

I actually profiled the timer ISR on a 600Mhz C3.  It runs for 22 usec.
So with HZ=1000 the residency of the timer interrupt is 2.2%.

Lee

