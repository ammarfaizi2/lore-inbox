Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVJZTFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVJZTFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVJZTFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:05:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:3812 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964862AbVJZTFd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:05:33 -0400
Message-ID: <3941240.1130353524290.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 26 Oct 2005 21:05:24 +0200 (CEST)
From: Andreas Kleen <ak@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Notifier chains are unsafe
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@ocs.com.au>,
       dipankar@in.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510261037280.4957-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-295-smp i386 (JVM 1.3.1_13)
Organization: SuSE Linux AG
References: <Pine.LNX.4.44L0.0510261037280.4957-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> On 26 Oct 2005, Andi Kleen wrote:
>
> > If you add locks to the reader make sure it is only taken
> > if the list is non empty. Otherwise you will add unacceptable
> > overhead to some fast paths.
>
> I don't understand this comment. What point is there in avoiding a
> lock
> when the list is empty?
 
It doesn't add locking overhead for a common case.
 
> Did you mean that a lock should be taken only if
> the list _is_ empty?

No.

> > Better would be likely to use RCU.
>
> Note that the RCU documentation says RCU critical sections are not
> allowed
> to sleep.
 
In this case it would be ok.

 
-Andi

