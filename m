Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbUDFSlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbUDFSlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:41:45 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31123
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263949AbUDFSln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:41:43 -0400
Date: Tue, 6 Apr 2004 20:41:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406184141.GH2234@dualathlon.random>
References: <4072EFEE.6050907@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4072EFEE.6050907@colorfullife.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 07:59:10PM +0200, Manfred Spraul wrote:
> Does AMD document how the CAM filter actually works? x86-64 writes into 
> the 4th level page table during a context switch and if I understand the 
> patent description correctly, this defeates the flush filter and forces 
> a full flush during a context switch.

this is something we discussed a few times during the early x86-64
development. The main question you should answer is what gains you to do
a partial flush if the only non global entries have to be flushed
anyways?
