Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUKXAJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUKXAJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUKWRel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:34:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:43146 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261361AbUKWQSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:18:00 -0500
Date: Tue, 23 Nov 2004 17:17:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: Bill Davidsen <davidsen@tmr.com>, Jakub Jelinek <jakub@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
In-Reply-To: <jehdngwqlt.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.53.0411231716480.5749@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
 <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
 <20041122113328.GQ10340@devserv.devel.redhat.com> <41A25D53.9050909@tmr.com>
 <je8y8t8n5t.fsf@sykes.suse.de> <Pine.LNX.4.53.0411231504560.28979@yvahk01.tjqt.qr>
 <jehdngwqlt.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>It's not a struct, it's an array (of one element of struct type).  You
>>>can't assign arrays.
>>
>> int callme(const char *fmt, struct { ... } argp[1]) {
>        struct { ... } dest[1];
>> 	dest = *argp;
>> }
>>
>> Maybe that way?
>
>Maybe you should just try.

I did not say that 'dest' was an array too, and in fact, was not thinking of
such, but more like:

int foo(struct bar argp[1]) {
 struct bar dest;
 dest = *argp;
}

