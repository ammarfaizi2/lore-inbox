Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWJJRJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWJJRJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWJJRJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:09:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:55681 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750956AbWJJRJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:09:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W8m6fs20BVLajGqMjktt7iGGhQaxIFQj9INJydWuNtPbV1SWfo8vIzBFsIoPYKnDj5UUOs5aaTKgg98VKlTUaRQViwAGUwt798Co+lEem+qOdC52MW4BZbYDfUcuUxSJZv0dHji9cdb0jBguLKvFz0Q2QD9d+lnh2RNusPSgbKU=
Message-ID: <d120d5000610101009h49904afeq61b8e7f5dab79346@mail.gmail.com>
Date: Tue, 10 Oct 2006 13:09:53 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "John Stultz" <johnstul@us.ibm.com>
Subject: Re: Keyboard Stuttering
Cc: "Frank Sorenson" <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       "David Gerber" <dg-lkml@zapek.com>
In-Reply-To: <200610061218.36883.dg-lkml@zapek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610061218.36883.dg-lkml@zapek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/06, David Gerber <dg-lkml@zapek.com> wrote:
> > I'm experiencing some severe keyboard stuttering on my laptop.  The
> > problem is particularly bad in X, and I believe it also occurs at the
> > console, though I'm having a difficult time verifying that.  The problem
> > shows up as repeated characters (not regular key-repeat-related), and
> > sometimes dropped key presses.
>
> (I'm not subscribed to the list, CC: to me if needed)
>
> Same problem here. Intel Core 2 Duo with 2.6.19-rc1 x86_64 SMP. Happens on
> 2.6.17 too. I use 'noapic' as a workaround but that disables one of the CPU
> core of course.
>
> I cannot reproduce the problem within the console nor gdm. Only on the X
> desktop.
>

John,

It looks like the only clocksource available on David's box is
"jiffies" although the processor shows that it supporst tsc and PM
timer is enabled and I think that this is what causes keyboard
stuttering in X. See http://bugzilla.kernel.org/show_bug.cgi?id=7291.
I believe clocksources is your turf, could you please take a look at
this.

Thanks!

-- 
Dmitry
