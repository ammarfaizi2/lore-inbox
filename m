Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268767AbRG0DTX>; Thu, 26 Jul 2001 23:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268766AbRG0DTN>; Thu, 26 Jul 2001 23:19:13 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:46090 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S268764AbRG0DTE>;
	Thu, 26 Jul 2001 23:19:04 -0400
From: tpepper@vato.org
Date: Thu, 26 Jul 2001 20:19:09 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Validating Pointers
Message-ID: <20010726201909.A19877@cb.vato.org>
In-Reply-To: <20010726100955.B18938@cb.vato.org> <E15Pogz-00048x-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E15Pogz-00048x-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 26, 2001 at 06:12:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu 26 Jul at 18:12:57 +0100 alan@lxorguk.ukuu.org.uk done said:
> 
> You can't pass kernel address as if they were userspace. It might happen to
> sometimes work on some architectures. Take a look at the set_fs() stuff

Am I?  I though I was doing a pretty plain user<->kernel copy:

	copy_to_user(user_addr, kernel_addr, size);
		and
	copy_from_user(kernel_addr, user_addr, size);

Are you saying that static and dynamically allocated kernel variables end up
in different segments (kernel_ds and user_ds) and the copy is only expected to
succeed if the to and from addresses are in the same segment?

Tim
