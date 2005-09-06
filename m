Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVIFXBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVIFXBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVIFXBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:01:18 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:38889 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751075AbVIFXBR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:01:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SKLL1wjXfHiEiEhezXHJCZCHp/Qh7PH8q1MUFHiPlkqwahQNcNkSaXQKaL5apx9yRcSXO5aOIA/h3OJO2iBB4eGn9ncUweBtFsdU1IbpuTZ75rKreaRgdVXna8jXnYKl59HNF0oQjo/3orVMui/FPPG4DwbA9cI81e6doxouF+4=
Message-ID: <d120d500050906160158912aaa@mail.gmail.com>
Date: Tue, 6 Sep 2005 18:01:12 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] PCI: Unhide SMBus on Compaq Evo N620c
Cc: Rumen Ivanov Zarev <rzarev@its.caltech.edu>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <1126046590.13159.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509062039.j86KdWMr014934@inky.its.caltech.edu>
	 <1126046590.13159.9.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-09-06 at 13:39 -0700, Rumen Ivanov Zarev wrote:
> > Trivial patch against 2.6.13 to unhide SMBus on Compaq Evo N620c laptop using
> > Intel 82855PM chipset.
> 
> > +     } else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ)) {
> 
> Should unlikely() be used for cases where the conditional will be true
> iff a specific piece of hardware is present?  Seems like we'd always
> lose.
> 

I would say that we should definitely not use [un]likely for code that
is executed once during boot.

-- 
Dmitry
