Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVEJTZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVEJTZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEJTZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:25:08 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:14695 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261756AbVEJTYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:24:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=rYwon5lJhfR8bM+Hx56ReFCtP6lMGoA7FRuxZFupowqOHXgF9vzg2iT9KmFffgo52YtRwpa48RTKXmYymnhbPaUUm31TVVx6Q8h8wSw5KpeVnF5M3PBSysmbNepua9p5nGR3V29h49VN9gvU/Q+3IqGZQ1PWtdYNnGJnJYdV+Yg=
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] bluetooth: kill redundant NULL checks and casts before kfree
Date: Tue, 10 May 2005 23:28:15 +0400
User-Agent: KMail/1.7.2
Cc: Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sf.net,
       Maxim Krasnyansky <maxk@qualcomm.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0505102100150.2386@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0505102100150.2386@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505102328.15734.adobriyan@mail.ru>
From: Alexey Dobriyan <adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 May 2005 23:05, Jesper Juhl wrote:

> There's no need to check for NULL before calling kfree() on a pointer, and
> since kfree() takes a void* argument there's no need to cast pointers to
> other types before passing them to kfree().

> +	kfree(hdev->driver_data)	

This won't compile.
