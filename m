Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVAVNBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVAVNBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 08:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVAVNBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 08:01:18 -0500
Received: from mproxy.gmail.com ([216.239.56.248]:37509 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262713AbVAVNBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 08:01:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hdP5Wkpa1/mJev0kaasgUK5K0PWfsfY1YVpabET631GYoxDVJIKKG+UJRrSbwlIH3708ijl8zBZqkOkCBRJbQRxaVMUiIwK6mk6O1SMFrObDkoNGmF6TBOoxOCdwTnVJX2vuXK5NRSr0+yaJC4RB6Y8B3RLyA8ZZreGO/1w+oqA=
Message-ID: <21d7e99705012205012c95665@mail.gmail.com>
Date: Sun, 23 Jan 2005 00:01:13 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, binary search result
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>
	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>
> 
> That's certainly correct.
> 
> > Such issues
> > could crash (all) user apps, but shouldn't prevent the machine from
> > responding to sysrq sequences.
> 
> You emphasized the differences of the effects. But there is one reason in
> all cases which I know: int10 crashes X or even the whole kernel.
> 
> I could debug the problem to the following point:
> 
> 
> I could see, that X crashes in glibc 2.3.4 with kernel 2.4.x (not with
> kernel 2.6.x, x <= 10, x > 10 not tested) during the first malloc syscall
> after int10 to execute the function
> xf86MsgVerb(X_INFO,3,"my comment\n");
> 
> The crashes depend on different versions of used software:
> 
> glibc 2.3.3 or 2.3.4 with kernel 2.4.x
> glibc 2.3.2 with kernel > 2.6.9rc2
> 


Well if you can track down which patch in -rc2 causes it then we can
annoy the person who created it, if you build some kernels from the bk
snapshots it might help as -rc2 is quite large vs -rc1..

Dave.
