Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTHTPSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTHTPSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:18:48 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:30982 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261999AbTHTPSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:18:46 -0400
Subject: Re: [OT] Connection tracking for IPSec
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Christophe Saout <christophe@saout.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061391227.5558.2.camel@chtephan.cs.pocnet.net>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
	 <1061381498.4210.16.camel@chtephan.cs.pocnet.net>
	 <1061389376.3804.16.camel@teapot.felipe-alfaro.com>
	 <1061391227.5558.2.camel@chtephan.cs.pocnet.net>
Content-Type: text/plain
Message-Id: <1061392721.3804.18.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 17:18:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 16:53, Christophe Saout wrote:
> > No... What I'm saying is that normal IP traffic is processed by the
> > firewall. However, if the incoming traffic is protected with IPSec,
> > since I opened up protocols 50 and 51, the IPSec traffic is admitted
> > without passing any remaining firewall filters. The machine in question
> > is an end host (not a router).
> 
> Yes, you're right. I just checked. Only the encrypted traffic passes the
> netfilter rules, never the unencrypted data. So if you open the
> protocols 50 and 51, the encrypted data can pass, gets
> encrypted/decrypted and that data can always pass unchecked.
> 
> These packets should get reinjected into the netfilter mechanism after
> decryption and should pass the rules before getting encrypted.

Exactly! Now, I dont know how to reinject the IPSec-decrypted packets
back to the netfilter engine. Anyone?

