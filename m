Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422774AbWHXW12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWHXW12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWHXW12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:27:28 -0400
Received: from web83111.mail.mud.yahoo.com ([216.252.101.40]:62904 "HELO
	web83111.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422774AbWHXW11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:27:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FOySKCPDfZ4e8EildGDrXOq3fD99dX+5ZyEijrfkjWFNF/hPv+SjgPV1e7dWred9HxfeB81OaC2zzJZDVEmVGbRwuoUcQysoRQGj29VAt77PC9rQ/9g/wgb+aR9mt/Dq4Tm4FQkkExxFgs1pm3IMtlht4P+D2pYEouGSRZWRMh8=  ;
Message-ID: <20060824222727.67706.qmail@web83111.mail.mud.yahoo.com>
Date: Thu, 24 Aug 2006 15:27:27 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Generic Disk Driver in Linux
To: Phillip Susi <psusi@cfl.rr.com>
Cc: arjan@infradead.org, jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, satinder.jeet@gmail.com
In-Reply-To: <44EE0DDA.5060600@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Phillip Susi <psusi@cfl.rr.com> wrote:

> The int 13 calls to the bios can only accept addresses within the first 
> 1 MB of memory, and the calls are synchronous, so DMA really doesn't 
> matter as the cpu will be busy waiting anyhow while the IO takes place, 
> which will wreak all kinds of hell on the rest of the running system, 
> including other hardware ISRs.
> 
  Not that easy. Once you start int13 transfer, your vm86 thread may be 
preempted to allow cpu doing something useful, including other ISRs processing.
