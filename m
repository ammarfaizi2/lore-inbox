Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRJAHCF>; Mon, 1 Oct 2001 03:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274656AbRJAHB5>; Mon, 1 Oct 2001 03:01:57 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:38641 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S274653AbRJAHBm>; Mon, 1 Oct 2001 03:01:42 -0400
From: Christoph Rohland <cr@sap.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 4GB MemShared, Cached bigger (and growing) than MemTotal (64MB) on 2.4.9-ac18
In-Reply-To: <20010930224453.C25387@mikef-linux.matchmail.com>
Organisation: SAP LinuxLab
Date: 01 Oct 2001 08:40:53 +0200
Message-ID: <m34rpj3lsa.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sun, 30 Sep 2001, Mike Fedyk wrote:
> Hi,
> 
> I took 64MB out of my 128MB system at home today just to see how
> 2.4.9-ac18 would work on it, and did some tests...
> 
> I ran apt-get update && apt-get upgrade, and after that finished,
> swapoff -a.
> 
> While looking at vmstat, the swap went down from 24000 to 16000 and
> slowed considerably (sorry didn't save the vmstat output) with the
> page cache getting smaller and smaller, while disk reads were
> constantly at about 2000.
> 
> After a while it got past 16000 swap, and down to zero and swapoff
> exited.
> 
> After this happened, I saw MemShared go up to about 4GB, and Cached
> started growing, getting even bigger than ram!

Apparently the shmem accounting is screwed. (Hugh does something ring
at your side?) 

This should be totally cosmetic. Simply add the MemShared to the
Cached field and you get the real cached (including shmem) pages.

Greetings
		Christoph


