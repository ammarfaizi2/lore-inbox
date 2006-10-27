Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWJ0Wbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWJ0Wbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWJ0Wbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:31:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:9578 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWJ0Wbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:31:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dBZORg5N+JhdC5uHR2SdQIXjy+eOM+dj4RUcshmnwgtu9MBI6lHq75QumLLMFOHKGNs+tCuz3yi/2dJ6a5yR/d3fAGh4tCprM4wY5iNr2/nGa3v2XNBX4c1ydeSJFF2P13dTztZ2HfbxDoXWZh8TiSuz78HPBugkh73g9qV5hRA=
Message-ID: <6b4e42d10610271531w51ec107s881389a9b541dbff@mail.gmail.com>
Date: Fri, 27 Oct 2006 15:31:32 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "=?ISO-8859-1?Q?Mika_Penttil=E4?=" <mika.penttila@kolumbus.fi>
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Andi Kleen" <ak@muc.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, randy.dunlap@oracle.com,
       clemens@ladisch.de, bob.picco@hp.com
In-Reply-To: <4541A758.9010504@kolumbus.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com>
	 <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com>
	 <20061027024238.GC58088@muc.de> <20061027055708.GA20270@suse.cz>
	 <4541A758.9010504@kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >
> There seems to be lot of confusion here. Current code isn't using hpet
> as tick source if legacy is not supported. This patch adds
> hpet_lrr_force but it's not clear how it interacts with hpet_use_timer -
> in some places it is hpet_use_timer and some (hpet_use_timer &&
> hpet_lrr_force).
>
> The timer is routed to ioapic pin 2 which is irq0 with source override.
> With this patch with hpet_lrr_force=1 timer irq is set to 2 for x86_64
> and 0 for i386, that can't be right?
Hmm... if hpet_lrr_force=1, timer irq should be set to 2 both in
x86_64 as well as i386.
This is my mistake. I should test more thoroughly :-(

Thanks for comments.
Om.

>
> --Mika
>
>
>
