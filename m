Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbTCZTBY>; Wed, 26 Mar 2003 14:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbTCZTBY>; Wed, 26 Mar 2003 14:01:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19132
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261884AbTCZTBW>; Wed, 26 Mar 2003 14:01:22 -0500
Subject: Re: [PATCH 2.5] fix OSS cs4232 linking when compiled-in
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bwindle-kbt@fint.org
In-Reply-To: <200303252311.32261.daniel.ritz@gmx.ch>
References: <200303252311.32261.daniel.ritz@gmx.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048710379.31839.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 20:26:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 22:11, Daniel Ritz wrote:
> hi
> 
> this patch fixes the linking of sound/oss/cs4232.c.
> unload_cs4232 can't be __exit since it's called from cs_4232_pnp_remove
> which isn't __exit.

Correct - but surely it shoudl be __devexit ?

