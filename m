Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSJKIIR>; Fri, 11 Oct 2002 04:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262422AbSJKIIR>; Fri, 11 Oct 2002 04:08:17 -0400
Received: from denise.shiny.it ([194.20.232.1]:23213 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S262418AbSJKIIQ>;
	Fri, 11 Oct 2002 04:08:16 -0400
Message-ID: <XFMail.20021011101359.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20021010224417.GA2673@matchmail.com>
Date: Fri, 11 Oct 2002 10:13:59 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: linux-kernel@vger.kernel.org, Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Oct-2002 Mike Fedyk wrote:
>> [...] I would
>> like a way to read the db so that the cached part of
>> the db (the 20% which gets 80% of accesses) is not
>> expunged.
>
> Unless you are pausing the database (causing the files on disk to be in a
> useful state) and then reading the file you will have trouble.  Anything
> else will have to syncronize with the database itself, and thus can't use
> O_STREAMING.

All the cached db pages will be dropped regardless its state. Any
further access to the db will read the data from disk again. I'm
talking only about performance, not about db coherency.

Bye.

