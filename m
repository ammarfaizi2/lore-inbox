Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271451AbRHOVJh>; Wed, 15 Aug 2001 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271448AbRHOVJ1>; Wed, 15 Aug 2001 17:09:27 -0400
Received: from t2.redhat.com ([199.183.24.243]:31728 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271446AbRHOVJM>; Wed, 15 Aug 2001 17:09:12 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <997905442.2135.6.camel@keller> 
In-Reply-To: <997905442.2135.6.camel@keller>  <997901702.2129.16.camel@keller> 
To: Georg Nikodym <georgn@somanetworks.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dell I8000, 2.4.8-ac5 and APM 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Aug 2001 22:09:17 +0100
Message-ID: <29219.997909757@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


georgn@somanetworks.com said:
> On my Dell I8000, when running 2.48-ac5 pulling the AC plug out (or
> plugging it back) causes the box to hang for a while prior to shutting
> itself off.

> Disabling APIC solves my immediate problem, so personally I'm happy. 

I've been chasing down APM problems on an I8000 today too - the Red Hat 7.2
beta kernel (which is based on some 2.4-ac) dies on resume, while a clean
2.4.9-pre4 survives. I'd noticed that the Red Hat kernel was using the local
APIC just before giving up on it for the day - turning that off will be the
first thing I try in the morning.

Apart from the hang on applying or removing power, were you also having 
this problem with APM suspend?

Strangely, APM suspend was working after a suspend-to-disk. It only failed 
after a clean boot.

--
dwmw2


