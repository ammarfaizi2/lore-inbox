Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVDFWPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVDFWPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVDFWPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:15:11 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:40779 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262332AbVDFWOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:14:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TqqnFtwDe2sehDcl5e13M8kBElxmnsuAqYxUd8JPG/dBTzwia8/Dzgmj8FBQT1u+eiZ54sJbGa9ahH4GQHg9Ni7aIBAZyL+R5p54BaLR9wYWvUKxSZh677By8VW1hYhD6DbUBNDU+8iH6Nz50kIgueZITFcM9/PkklP0h7dNJBw=
Message-ID: <aec7e5c305040615146766e121@mail.gmail.com>
Date: Thu, 7 Apr 2005 00:14:28 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Malcolm Rowe <malcolm-linux@farside.org.uk>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <courier.4253F216.00001A20@mail.farside.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405225747.15125.8087.59570@clementine.local>
	 <courier.4253BAD7.000018D2@mail.farside.org.uk>
	 <aec7e5c305040606104c86712c@mail.gmail.com>
	 <courier.4253F216.00001A20@mail.farside.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2005 4:28 PM, Malcolm Rowe <malcolm-linux@farside.org.uk> wrote:
> Magnus Damm writes:
> > And I guess the idea of replacing the initcall pointer with NULL will
> > work both with and without function descriptors, right? So we should
> > be safe on IA64 and PPC64.
> 
> I think so, though I don't really know a great deal about this area.
> 
> An IA64 descriptor is of the form { &code, &data_context }, and a function
> pointer is a pointer to such a descriptor. Presumably, setting a function
> pointer to NULL will either end up setting the pointer-to-descriptor to NULL
> or the code pointer to NULL, but either way, I would expect the 'if
> (!*call)' comparison to work as intended.
> 
> Best thing would be to get someone on IA64 and/or PPC64 to check this for
> you. 

I agree. Do we have any friendly IA64/PPC64 user out there?

> Also might be worth checking that the patch works as intended with
> CONFIG_MODULES=n (assuming you haven't already).

The code works both with CONFIG_MODULES set to "y" and unset.

Thanks,

/ magnus
