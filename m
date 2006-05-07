Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWEGNs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWEGNs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWEGNs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:48:57 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:60885
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932167AbWEGNs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:48:56 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [patch 2/6] New Generic HW RNG
Date: Sun, 7 May 2006 15:56:01 +0200
User-Agent: KMail/1.9.1
References: <20060507113513.418451000@pc1> <200605071527.33376.mb@bu3sch.de> <20060507134527.GA14704@procyon.home>
In-Reply-To: <20060507134527.GA14704@procyon.home>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071556.01936.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 15:45, you wrote:
> On Sun, May 07, 2006 at 03:27:33PM +0200, Michael Buesch wrote:
> > On Sunday 07 May 2006 15:16, you wrote:
> > > On Sunday 07 May 2006 15:03, you wrote:
> > > > This does not handle the case of partial read correctly - the code
> > > > should be
> > > > 
> > > > 			return ret ? : -ERESTARTSYS;
> > 
> > Or, hm. Shouldn't we
> > return ret ? : err;
> > 
> > err is -EINTR
> 
> -ERESTARTSYS is the proper return code for this case - the signal
> handling code will either convert it to EINTR for userspace, or
> restart the system call after handling the signal, depending on the
> state of the SA_RESTART flag set by sigaction().

Ok, I fixed all your stuff. Thanks.
I will run some more tests now and re-submit, if noone else finds a bug. ;)

-- 
Greetings Michael.
