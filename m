Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313509AbSDQLBj>; Wed, 17 Apr 2002 07:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313536AbSDQLBi>; Wed, 17 Apr 2002 07:01:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64014 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313509AbSDQLBh>; Wed, 17 Apr 2002 07:01:37 -0400
Subject: Re: oops report (or at least a try to make one)
To: bzd@astercity.net (Artur Brodowski)
Date: Wed, 17 Apr 2002 12:19:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020417122713.404e0cdd.bzd@astercity.net> from "Artur Brodowski" at Apr 17, 2002 12:27:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xnTG-00023U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> first i thought the reason could be that i use nvidia driver, as it gives
> a warning about tainted kernel, but i used it for a while before on the
> same machine/same kernel version, and there were no problems. also, this
> error indicates it's kswapd issue.

Unfortunately something like a memory scribble often shows up in
kswapd or other code that walks long lists (dcache is another common place
it shows up). I make no judgement either way on the Nvidia driver being a
factor but the report only really becomes really interesting if you can
replicate it without the nvidia driver being loaded that boot.

If this is a one off from a box thats mostly stable anyway it gets tricky
