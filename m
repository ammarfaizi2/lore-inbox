Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWGPSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWGPSir (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWGPSir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 14:38:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:38845 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751159AbWGPSiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 14:38:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aZT913Fi30cPzMoyUSd2rKKE0pUVgVy4mxv6j6ycJeYmWzv+hxoEGF62FrFYyr6B/9S+iAiiqjmVrPIeOTMiDk0z04oo9iXeKWuxUH6XsUstO99Q++ZvocdIJhpkpL3TVMIvCtj1eREw4G4hGZDjv74gSxjHusPHpDe4ES7FrLs=
Message-ID: <787b0d920607161138l4b6dc25dycaeaaea5e948c769@mail.gmail.com>
Date: Sun, 16 Jul 2006 14:38:45 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Subject: Re: 2.6.18 Headers - Long
Cc: dwmw2@infradead.org, arjan@infradead.org, maillist@jg555.com,
       ralf@linux-mips.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
	 <6C943713-549B-453C-A0B2-1286764FFE13@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Jul 15, 2006, at 17:09:28, Albert Cahalan wrote:

> You realize that on a couple architectures it's fundamentally
> impossible to get atomic ops completely in userspace, right?

Sure. Those architectures don't need to drag down the rest.
Plenty of headers are only exported for some architectures.

(Well actually, such architectures could just give apps a
writable flag to disable the scheduler -- this is acceptable
for the embedded things these architectures are used for.
I've seen it done for user-space spinlocks. It works great.)

It's not as if the app developers would care to support
those architectures anyway. They don't even support all
the non-defective ones: I use the second or third most
popular architecture (ppc), and the app developers have
made it very clear that they don't give a damn. Something
else will get you: char being unsigned by default, wrong
endianness, stack growing the HP way, etc.
