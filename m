Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWEJS2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWEJS2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWEJS2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:28:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14293 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751495AbWEJS2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:28:13 -0400
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Date: Wed, 10 May 2006 20:28:22 +0200
User-Agent: KMail/1.9.1
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Stephen Hemminger <shemminger@osdl.org>, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       netdev@vger.kernel.org
References: <20060509084945.373541000@sous-sol.org> <6a1855ab01a195ac2a28a97c5f966f67@cl.cam.ac.uk> <ada1wv3apu0.fsf@cisco.com>
In-Reply-To: <ada1wv3apu0.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605102028.22974.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 22:46, Roland Dreier wrote:
>     Keir> Where should we get our entropy from in a VM environment?
>     Keir> Leaving the pool empty can cause processes to hang.
>
> You could have something like a virtual HW RNG driver (with a frontend
> and backend), which steals from the dom0 /dev/random pool.

They already have a vTPM - iirc TPMs support random numbers so
that could be used. But it's probably complicated to use.

But if sampling virtual events for randomness is really unsafe (is it 
really?) then native guests in Xen would also get bad random numbers
and this would need to be somehow addressed.

I haven't seen real evidence yet why the virtual events should 
provide less randomness than the hardware.

-And
