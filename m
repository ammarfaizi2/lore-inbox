Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946405AbWJSTup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946405AbWJSTup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946407AbWJSTup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:50:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:29025 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946405AbWJSTuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:50:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ehRKcVLavSnrerukRmPiyn6m8vn+FXRx6DHIDZT4Z1BStPnuo0SjJA+NAxeFqn0udyB6Qyl5SphWsWJKnQjJiy1sD4SnvpBqLOpCoqAj9e6j/rHGvgBAmgYNhRHJb/T4YwfU5ZQi4AbEQGnFFWGvgdIQWfV4EMwacsOLAyhnc6A=
Date: Thu, 19 Oct 2006 23:50:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Cal Peake <cp@absolutedigital.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Improve the remove sysctl warnings.
Message-ID: <20061019195040.GA5392@martell.zuzino.mipt.ru>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com> <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org> <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net> <20061018124415.e45ece22.akpm@osdl.org> <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 12:25:20PM -0400, Cal Peake wrote:
> On Wed, 18 Oct 2006, Eric W. Biederman wrote:
>
> >  	if (msg_count < 5) {
> >  		msg_count++;
> >  		printk(KERN_INFO
> >  			"warning: process `%s' used the removed sysctl "
> > -			"system call\n", current->comm);
> > +			"system call with ", current->comm);
> > +		for (i = 0; i < tmp.nlen; i++)
> > +			printk("%d.", name[i]);
> > +		printk("\n");
> >  	}
>
> We should prolly kill the counter now.

sysctl(2) callable by everyone including local lusers willing to fill logs.

