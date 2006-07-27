Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWG0SKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWG0SKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWG0SKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:10:39 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:37052 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751912AbWG0SKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:10:38 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Petr Baudis <pasky@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <20060727180634.GA28962@pasky.or.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060727180634.GA28962@pasky.or.cz>
Date: Thu, 27 Jul 2006 21:10:36 +0300
Message-Id: <1154023836.7190.3.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 20:06 +0200, Petr Baudis wrote:
> Make that setuid root or just create log file owned by you and make root
> run it.  Should be innocent enough, right?
> 
> Well, except that you can revoke the log file before the shadow file is
> opened, at which point open() probably reuses the fd and the program
> conveniently logs to /etc/shadow.

No, the fd is leaked on purpose to avoid recycling. See revoke_fds for
details.

