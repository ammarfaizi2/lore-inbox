Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274669AbRJEXwk>; Fri, 5 Oct 2001 19:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274683AbRJEXwa>; Fri, 5 Oct 2001 19:52:30 -0400
Received: from smi-105.smith.uml.edu ([129.63.206.105]:61958 "HELO
	buick.pennace.org") by vger.kernel.org with SMTP id <S274669AbRJEXwM>;
	Fri, 5 Oct 2001 19:52:12 -0400
Date: Fri, 5 Oct 2001 19:52:28 -0400
From: Alex Pennace <alex@pennace.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Desperately missing a working "pselect()" or similar...
Message-ID: <20011005195228.B6981@buick.pennace.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20011005190523.A6516@buick.pennace.org> <E15pe9z-0007yv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15pe9z-0007yv-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 12:13:17AM +0100, Alan Cox wrote:
> > The select system call doesn't return EINTR when the signal is caught
> > prior to entry into select.
> 
> Your friend there is siglongjmp/sigsetjmp - the same problem was true
> with old versions of alarm that did
> 
> 	alarm(num)
> 	pause()
> 
> on a heavily loaded box.
> 
> Using siglongjmp cures that

I was naive about siglongjump bouncing through the stack over a system
call, but it appears to be safe. Excellent.
