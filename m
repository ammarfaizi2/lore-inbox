Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWIKLFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWIKLFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 07:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWIKLFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 07:05:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:25044 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751044AbWIKLFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 07:05:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iIa+fy7ifVOxFbx6i9HhTkmiB0wav9viu2ylKOiBs+f0L9sojahCnntH8l9jowoSvpqlp2C9MoKFxmsUfD2lWzKQ7VVuFtqYXVWd3QDvA0JulHdwImo+xQRki+w5MItAe4fpkqOiptMUnZU8DkADL4yDqshYO2S0/xETTTF/l3M=
Message-ID: <1b270aae0609110405r183748d2y753c0e846229f1d0@mail.gmail.com>
Date: Mon, 11 Sep 2006 13:05:41 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: top displaying 50% si time and 50% idle on idle machine
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060908224752.GK8793@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com>
	 <20060907175323.57a5c6b0.akpm@osdl.org>
	 <1b270aae0609081403u11b76ae9v72ad933475a2319f@mail.gmail.com>
	 <20060908224752.GK8793@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0%
>>>>wa,  0.0% hi, 50.0%si

>> BTW what means si? (interrupt service time? google
>> didn't find anything)

> 'soft interrupt' probably. try disconnecting network.

The cause has been found. The timer of that machine is seriously
broken, 1 second is approximately 500ms long.
It is a HP DL360 G4 and I configured the kernel without ACPI or
similar. Maybe there are some strange BIOS power management schemes
active. I will look deeper into the problem and report back.
A broken timer is _very_ strange to me (I didn't encounter that in the
last 12 years w/ custom kernels).

Cheers,
M.
