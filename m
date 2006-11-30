Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967837AbWK3Rrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967837AbWK3Rrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967839AbWK3Rrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:47:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:64056 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S967837AbWK3Rrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:47:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AbJVYWIKx2lH7ZimwtYfg+iFsbYeHQx+4aGOYnvLTPtLSoQIF7dgcro6POv47HBvZT2zO9ZpFTD2ce7dOE3DCReWBphkZwgnZJwIhI+pon0T+purZDYz7XQptAr5Tte6uAbOiIVcSkJPxif7kwL2vtmuIG+eoun7kExDsIt8nMc=
Message-ID: <41840b750611300947t5e72b4c1t356fb03fe9d31c68@mail.gmail.com>
Date: Thu, 30 Nov 2006 19:47:36 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Cc: "Christoph Schmid" <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20061130171102.GC1860@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <455DAF74.1050203@schlagmichtod.de> <20061121205124.GB4199@ucw.cz>
	 <41840b750611231026r790cd327q7e48ebd99f9b9350@mail.gmail.com>
	 <20061130171102.GC1860@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/06, Pavel Machek <pavel@ucw.cz> wrote:
> > >Does hdaps work for you, btw? It gave all zeros on my x60, iirc.
> >
> > Yes, vanilla hdaps is broken. It blindly issues commands to the
> > embedded controller without following the protocol or checking the
> > status. The patched version in the tp_smapi package fixes it.
>
> Is there a way to extract minimal patch? ...the kind that is trivial
> enough so that akpm does accepts it...?

I can't think of any such trivial fix. My submitted code includes a
whole new driver, thinkpad_ec, just to get the (fully documented!) EC
protocl right. You could strip a few code paths which hdaps doesn't
invoke, but it's hard to see how you can get away with much less
except by making unwarranted assumptions about the hardware and its
timing characteristics.

  Shem
