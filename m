Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVFBWrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVFBWrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVFBWqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:46:23 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:6419 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S261564AbVFBWpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:45:25 -0400
Message-ID: <429F8C00.3070803@stud.feec.vutbr.cz>
Date: Fri, 03 Jun 2005 00:45:20 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu> <429EFB66.8030909@stud.feec.vutbr.cz> <20050602123927.GB10878@elte.hu> <429F4A19.7030508@stud.feec.vutbr.cz> <20050602183343.GB30309@elte.hu>
In-Reply-To: <20050602183343.GB30309@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> hm, one difference is that i'm running a 64-bit kernel but 32-bit 
> userspace (FC3-ish).

Yes, that's it! I've just successfully booted into 32-bit userspace (I 
have a separate partition with old 32-bit Debian) with x86_64 kernel and 
LATENCY_TRACE enabled. Everything seemed to work.
Then I mounted my normal root partition under /mnt/64 and tried
   chroot /mnt/64
I got a SIGSEGV. Then I copied some simple binaries from /mnt/64/bin to 
/root/test/bin and some necessary libraries to /root/test/lib and did
   chroot /root/test
I could run 64-bit sash, ls, cat, date, mkdir - it worked. 64-bit bash 
however segfaulted.

Michal
