Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWE0RJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWE0RJD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWE0RJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 13:09:03 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:31796 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964906AbWE0RJB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 13:09:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sOWkRkhYBX3s2DVQ4dlTVLas0corSSareIdeZcFssZO8YcrU35y7WNuxQnMslaqJQwU2Dv5bQCNkyB8U9oP3blevnTQcRR9nlhf1T0wKyPul/8QLf5QLISXwYpWEUy5bjCJe7sYQca1Un1vMoQ3c0AU06x23yGtOc6KqZ6ApgnY=
Message-ID: <58d0dbf10605271009s2b709250k115f31ed13be3b68@mail.gmail.com>
Date: Sat, 27 May 2006 19:09:01 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Subject: Re: gcc-4.1.1/kernel 2.6.16.18 - miscompiled external module (old parameter not found)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605271206.34427.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605271206.34427.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/5/27, Andrey Borzenkov <arvidjaar@mail.ru>:
> After recompilation with new compiler of wifi driver I got:
>
> wlags49_h1_cs: falsely claims to have parameter channel
> wlags49_h1_cs: falsely claims to have parameter channel
> wlags49_h1_cs: falsely claims to have parameter channel
> wlags49_h1_cs: falsely claims to have parameter channel
>
...
>
> The distribution is Mandriva with gcc-4.1.1-1mdk, stock 2.6.16.18.

I observed the same effect with different code on a suse 10.1 box
(gcc-4.1) against 2.6.16.16. Is this a wanted breakage?

At least this made me start porting the involved code to the new
parameter scheme (and develop a strategy for 2.4 compatibility -
module_param_array wrapping...).

Jan
