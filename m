Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbTHTOyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTHTOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:54:04 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:29659 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S261992AbTHTOyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:54:01 -0400
Subject: Re: [OT] Connection tracking for IPSec
From: Christophe Saout <christophe@saout.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061389376.3804.16.camel@teapot.felipe-alfaro.com>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
	 <1061381498.4210.16.camel@chtephan.cs.pocnet.net>
	 <1061389376.3804.16.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1061391227.5558.2.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 16:53:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, 2003-08-20 um 16.22 schrieb Felipe Alfaro Solana:
>  saying it's not honouring the netfilter rules at all?
> 
> No... What I'm saying is that normal IP traffic is processed by the
> firewall. However, if the incoming traffic is protected with IPSec,
> since I opened up protocols 50 and 51, the IPSec traffic is admitted
> without passing any remaining firewall filters. The machine in question
> is an end host (not a router).

Yes, you're right. I just checked. Only the encrypted traffic passes the
netfilter rules, never the unencrypted data. So if you open the
protocols 50 and 51, the encrypted data can pass, gets
encrypted/decrypted and that data can always pass unchecked.

These packets should get reinjected into the netfilter mechanism after
decryption and should pass the rules before getting encrypted.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

