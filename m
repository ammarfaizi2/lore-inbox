Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWH2N0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWH2N0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWH2N0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:26:15 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:53475 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964953AbWH2N0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:26:14 -0400
Message-ID: <44F44072.4020506@bigpond.net.au>
Date: Tue, 29 Aug 2006 23:26:10 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Christoph Hellwig <hch@infradead.org>, Nicholas Miell <nmiell@comcast.net>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org> <Pine.LNX.4.61.0608281255100.14305@yvahk01.tjqt.qr> <44F2DEDC.3020608@student.ltu.se> <1156792540.2367.2.camel@entropy> <20060829114143.GB4076@infradead.org> <Pine.LNX.4.61.0608291416370.8031@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608291416370.8031@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Tue, 29 Aug 2006 13:26:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>> That is error-prone. Not "==FALSE" but what happens if x is (for some 
>>>> reason) not 1 and then "if (x==TRUE)".
>>> If you're using _Bool, that isn't possible. (Except at the boundaries
>>> where you have to validate untrusted data -- and the compiler makes that
>>> more difficult, because it "knows" that a _Bool can only be 0 or 1 and
>>> therefore your check to see if it's not 0 or 1 can "safely" be
>>> eliminated.)
>> gcc lets you happily assign any integer value to bool/_Bool, so unless
> 
> But, it coerces the rvalue into 0 or 1, which may be a gain.

Actually, it's not coercion.  It's the result of evaluating the value as 
a boolean expression.

> 
>> you write sparse support for actually checking things there's not the
>> slightest advantage in value range checking.
> 
> 
> Jan Engelhardt


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
