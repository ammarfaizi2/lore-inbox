Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266997AbTGTMOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 08:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267004AbTGTMOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 08:14:33 -0400
Received: from zork.zork.net ([64.81.246.102]:52432 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266997AbTGTMOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 08:14:32 -0400
To: James Morris <jmorris@intercode.com.au>
Cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
References: <Mutt.LNX.4.44.0307201552580.22965-100000@excalibur.intercode.com.au>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: James Morris <jmorris@intercode.com.au>,
 netdev@oss.sgi.com,  <linux-kernel@vger.kernel.org>
In-Reply-To: <Mutt.LNX.4.44.0307201552580.22965-100000@excalibur.intercode.com.au> (James
 Morris's message of "Sun, 20 Jul 2003 15:58:13 +1000 (EST)")
Date: Sun, 20 Jul 2003 13:29:24 +0100
Message-ID: <6u8yqt8jq3.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@intercode.com.au> writes:

> On Sat, 19 Jul 2003, Sean Neakums wrote:
>
>> twenty.  The problem seems unrelated to the amount of data
>> transferred; I've tried both bulk rsync transfers and ssh sessions.
>> I've also tested the same boxes over 100baseT; still happens.
>
> It sounds a bit like a pmtu problem related to the wireless bridge, but 
> that would be dependent on amount of data transferred and should not 
> happen on 100baseT.

I am seeing a lot of "pmtu discvovery on SA AH/03537192/c0a80003" type
messages (I forgot to check for them when on 100baseT; will recheck
that).  Are these indicative of such a problem?  I seem to recall that
reducing the max MTU is not as straightforward as just adjusting the
interfaces' mtu setting.  What should I do to eliminate pmtu as the
source of the problem?

> Transport mode (just blowfish encryption) looks to be working ok for me,
> I'm able to ftp uncompressed kernel tarballs between two boxes over 
> gigabit ethernet with no apparent problems.

I had been using 3des with AH; just retried with blowfish 448 and no
AH with much the same result.

