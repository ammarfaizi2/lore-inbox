Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWHHMbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWHHMbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWHHMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:31:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:46257 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964869AbWHHMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:31:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Yxbn2xm/oWIQTzxB5TYxk9xCelxaxurdKJyaxDPHLmGBurr4vmbH5mjS87KARcVHbCYSKrTb0jv0VfYMKG3ALOr9qfzLORY/d1EJVPR0+cx6B7aK2qhKlmtyYvwHGwSFK8fTHe+5tUFr/hv1ITcfKE3N8xC1No6P287J8KbhVVQ=
Message-ID: <84144f020608080531y72f8ec41n54196eee6b797279@mail.gmail.com>
Date: Tue, 8 Aug 2006 15:31:20 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: "Edgar Toernig" <froese@gmx.de>, "Pavel Machek" <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <1155040157.5729.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <1155040157.5729.34.camel@localhost.localdomain>
X-Google-Sender-Auth: 6fd06d997d96cd88
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-07 am 22:41 +0200, ysgrifennodd Edgar Toernig:
> > Your implementation is much cruder - it simply takes the fd
> > away from the app; any future use gives EBADF.  As a bonus,

On 8/8/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> It needs to give -ENXIO/0 as per BSD that much is clear.

I assume you mean devices only? EBADF makes sense for regular files,
except for close(2), maybe, for which zero is probably more
appropriate.

                                          Pekka
