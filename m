Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933394AbWK0UiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933394AbWK0UiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933390AbWK0UiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:38:08 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:8519 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S933356AbWK0UiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:38:06 -0500
Message-ID: <456B4CD2.7090208@cfl.rr.com>
Date: Mon, 27 Nov 2006 15:38:42 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <456B0F53.90209@cfl.rr.com> <456B101D.3040803@nortel.com> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu>
In-Reply-To: <ekfehh$kbu$1@taverner.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 20:38:20.0025 (UTC) FILETIME=[F97ED690:01C71263]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14838.003
X-TM-AS-Result: No--7.012300-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> Nope, I don't think so.  If they could, that would be a security hole,
> but /dev/{,u}random was designed to try to make this impossible, assuming
> the cryptographic algorithms are secure.
> 
> After all, some of the entropy sources come from untrusted sources and
> could be manipulated by an external adversary who doesn't have any
> account on your machine (root or non-root), so the scheme has to be
> secure against introduction of maliciously chosen samples in any event.

Assuming it works because it would be a bug if it didn't is a logical 
fallacy.  Either the new entropy pool is guaranteed to be improved by 
injecting data or it isn't.  If it is, then only root should be allowed 
to inject data.  If it isn't, then the entropy estimate should increase 
when the pool is stirred.

