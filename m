Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbUBXCY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 21:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUBXCY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 21:24:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43723 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262082AbUBXCYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 21:24:25 -0500
Date: Tue, 24 Feb 2004 02:24:24 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts_fs.h fails with "error: parameter name omitted"
Message-ID: <20040224022424.GL31035@parcelfarce.linux.theplanet.co.uk>
References: <20040224021651.GF1200@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224021651.GF1200@cse.unsw.EDU.AU>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 01:16:51PM +1100, Ian Wienand wrote:

> -int devpts_pty_new(struct tty_struct *); /* mknod in devpts */
> -struct tty_struct *devpts_get_tty(int);	 /* get tty structure */
> -void devpts_pty_kill(int);		 /* unlink */
> +int devpts_pty_new(struct tty_struct *tty);      /* mknod in devpts */
> +struct tty_struct *devpts_get_tty(int number);	 /* get tty structure */
> +void devpts_pty_kill(int number);		 /* unlink */

  
>  /* Dummy stubs in the no-pty case */
> -static inline int devpts_pty_new(struct tty_struct *) { return -EINVAL; }
> -static inline struct tty_struct *devpts_get_tty(int)  { return NULL; }
> -static inline void devpts_pty_kill(int) { }
> +static inline int devpts_pty_new(struct tty_struct *tty) { return -EINVAL; }
> +static inline struct tty_struct *devpts_get_tty(int number) { return NULL; }
> +static inline void devpts_pty_kill(int number) { }

That part makes sense.  Previous one doesn't.
