Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTAFOnA>; Mon, 6 Jan 2003 09:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbTAFOnA>; Mon, 6 Jan 2003 09:43:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:133
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266041AbTAFOnA>; Mon, 6 Jan 2003 09:43:00 -0500
Subject: Re: Why do some net drivers require __OPTIMIZE__?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Bennee <alex@braddahead.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041863609.21044.11.camel@cambridge.braddahead>
References: <1041863609.21044.11.camel@cambridge.braddahead>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041867367.17472.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 15:36:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anybody know the history behind those lines? Do they serve any
> purpose now or in the past? Should I be nervous about compiling the
> kernel at a *lower* than normal optimization level? After all
> optimizations are generally processor specific and shouldn't affect the
> meaning of the C.

Some of our inline and asm blocks assume things like optimisation. Killing
that check and adding -finline-functions ought to be enough to get what
you expect.

