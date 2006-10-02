Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965381AbWJBTcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbWJBTcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbWJBTcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:32:05 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:33664 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S965381AbWJBTcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:32:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=QJH9JtEB8/I7/kvbREUsEuAXME0KDH4+SY2Aev1KD9D9B+1Vl8F10tJF2MufDfMf;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <010a01c6e659$65a7a040$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Linus Torvalds" <torvalds@osdl.org>, <Valdis.Kletnieks@vt.edu>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <1159539793.7086.91.camel@mindpipe> <20061002100302.GS16047@mea-ext.zmailer.org> <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain>            <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org> <200610021822.k92IMo44008167@turing-police.cc.vt.edu> <Pine.LNX.4.64.0610021129150.3952@g5.osdl.org>
Subject: Re: Spam, bogofilter, etc
Date: Mon, 2 Oct 2006 12:31:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120fe5f52ac02aa33cbe406ba2c3732274d9822d29d99174f51350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.187.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Linus Torvalds" <torvalds@osdl.org>
> On Mon, 2 Oct 2006, Valdis.Kletnieks@vt.edu wrote:
>> 
>> How did OSDL's MX checking deal with split in/out configurations like ours,
>> where our MX points at a load-balanced farm of Mirapoint front end appliances
>> with 1 IP address, but our main off-campus *outbound* comes from a different
>> address?
> 
> Hey, if I knew what I was doing, I'd be in MIS. 
> 
> As it is, I just criticise other peoples patches.

DK or DKIM comes to mind. SpamAssassin 3.1.5 handles it neatly.

Off hand expecting a list to maintain perfect anti-spam is rather
difficult. Distributed processing works better. Folks should have
their own anti-spam tools and train them to their own preferences.

(It helps with a list like this one to have a SpamAssassin meta
rule that boosts the scores for BAYES_80 and above while reducing
scores for BAYES_40 and below. It also helps to run a lot of the
SARE, SpamAssassin Rules Emporium, rule sets. Pick and choose for
your particular needs. http://www.rulesemporium.com/rules)

{^_^}   Joanne
