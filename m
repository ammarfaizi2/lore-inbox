Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRKSIxS>; Mon, 19 Nov 2001 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276094AbRKSIxI>; Mon, 19 Nov 2001 03:53:08 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:23048 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S275693AbRKSIwu>;
	Mon, 19 Nov 2001 03:52:50 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111190852.fAJ8qel110464@saturn.cs.uml.edu>
Subject: Re: [PATCH] NTFS sparc compile fix
To: aia21@cus.cam.ac.uk (Anton Altaparmakov)
Date: Mon, 19 Nov 2001 03:52:40 -0500 (EST)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <E1607WV-0001xb-00@libra.cus.cam.ac.uk> from "Anton Altaparmakov" at Nov 03, 2001 08:36:11 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please apply below patchlet for your next releases (applies cleanly to
> any recent kernel). It fixes compilation of NTFS driver on Sparc.
...
> +	ATTR_IS_ENCRYPTED       = __constant_cpu_to_le16(0x4000),
> +	ATTR_IS_SPARSE          = __constant_cpu_to_le16(0x8000),

Can't SPARC be fixed with something like __builtin_constant_p() ?
It sure looks ugly to need __constant_cpu_to_le16() in a driver.
