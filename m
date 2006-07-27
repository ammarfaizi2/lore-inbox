Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWG0Pvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWG0Pvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWG0Pvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:51:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:29651 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750814AbWG0Pvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:51:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gWX8o4jl4SU5z4pvCSI1b7zlIuIknR0RMOspSv7QpfGj9o1mB8wZP+4JBlVtxzFWw33pL55JAMAe0dkivQ0T2RjxtlEIRWU8C0Mw5be/x5onuLkGMipjGDBLqi0Cr18+sU9pNUGW69D5b+mzQbmBa+putRRoOUJrgx1kdtFGWxk=
Message-ID: <f96157c40607270851i1e791774i81a557e6f0386c87@mail.gmail.com>
Date: Thu, 27 Jul 2006 15:51:50 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] fix Intel RNG detection
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <44C8FB44.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44C8BE63.76E4.0078.0@novell.com>
	 <f96157c40607270818p2cfec277x7eaf8eb2f3767268@mail.gmail.com>
	 <f96157c40607270835l34cd0de1w8c8a0d95ba8ee39f@mail.gmail.com>
	 <44C8FB44.76E4.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Jan Beulich <jbeulich@novell.com> wrote:
> ># dmesg | grep rng
> >intel_rng: FWH not detected
> >
> >looks like this ProLiant box with the ICH5 chip has no usable RNG
> >included, or should it?
>
> A configuration like this is what actually motivated me to write the
> patch. You need to remember that the RNG doesn't live in the ICH, but in
> the FWH (which is a different chip not showing up as a separate device
> anywhere) with only some access parameters being configured via the LPC
> device inside the ICH.

well, then let's push it into Linus' tree after the proposed cleanups.
