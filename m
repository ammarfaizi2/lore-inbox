Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTIEBW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbTIEBW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:22:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:2466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261826AbTIEBWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:22:55 -0400
Message-ID: <32935.4.4.25.4.1062724973.squirrel@www.osdl.org>
Date: Thu, 4 Sep 2003 18:22:53 -0700 (PDT)
Subject: Re: [PATCH] ikconfig - resolve rebuild permissions
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <sam@ravnborg.org>
In-Reply-To: <32901.4.4.25.4.1062724109.squirrel@www.osdl.org>
References: <20030904113133.3f950a51.shemminger@osdl.org>
        <20030904191353.GA10448@mars.ravnborg.org>
        <32901.4.4.25.4.1062724109.squirrel@www.osdl.org>
X-Priority: 3
Importance: Normal
Cc: <shemminger@osdl.org>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Thu, Sep 04, 2003 at 11:31:33AM -0700, Stephen Hemminger wrote:
>>> This patch fixes it by removing the configs.o file when
>>> needed.
>>
>> A better approach would be to remove the need for compile.h from
>> configs.c. See attached patch for the makefile change.
>> It just took the relevant part from mk_compile and
>> used it in the Makefile.
>> Example only - I expect Randy to integrate it properly.
>
> configs.o also wants UTS_RELEASE from compile.h, and

UTS_RELEASE is not from compile.h....
so Sam's patch looks reasonable, working on it now.

> I really dislike generating the same data in multiple places,
> so I prefer to continue to use compile.h.
> I'll see about other options or using Steve's patch.

~Randy



