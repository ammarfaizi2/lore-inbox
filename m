Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbSKAQyk>; Fri, 1 Nov 2002 11:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265347AbSKAQyk>; Fri, 1 Nov 2002 11:54:40 -0500
Received: from med-gwia-02a.med.umich.edu ([141.214.93.150]:9355 "EHLO
	mail-02.med.umich.edu") by vger.kernel.org with ESMTP
	id <S265337AbSKAQyV> convert rfc822-to-8bit; Fri, 1 Nov 2002 11:54:21 -0500
Message-Id: <sdc26cf0.091@mail-02.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Fri, 01 Nov 2002 12:00:36 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <pochini@denise.shiny.it>, <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx and error recovery
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the time I read  your original post, I was investigating why one drive kept being kicked out of an md array.

This is on two systems, 2.4.20-pre11 and 2.4.20-rc1, and both using a symc53c875 with 36gb IBM drives.

Turns out it's recovered errors, just like you see.

So it seems to be wider than aic7xxx. I've just rebuilt both arrays with PER 0, and they're working fine.

Another array on 2.4.19-pre7 & aic7xxx works fine with PER 1

Nik


>>> Giuliano Pochini <pochini@denise.shiny.it> 11/01/02 03:16AM >>>
Giuliano Pochini wrote:
>
> [...] It happens that when a recoverable error occurs (as
> reported in the sys logs) read()(2) returns a value smaller then
> requested, and the loaded data is identical to the pattern, or
> read() completes, but the data is wrong.

Ehm, I made a stupid typo in my test program. read() does dot
succeed in the second case. Anyway the problem is still here:
why does it fail on recovered errors ?


Bye.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

