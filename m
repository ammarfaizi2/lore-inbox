Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285236AbRLFVyF>; Thu, 6 Dec 2001 16:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285235AbRLFVxz>; Thu, 6 Dec 2001 16:53:55 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:7921 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S285237AbRLFVxn>; Thu, 6 Dec 2001 16:53:43 -0500
Date: Thu, 6 Dec 2001 13:45:19 -0800
From: Chris Wright <chris@wirex.com>
To: Nav Mundi <nmundi@karthika.com>
Cc: linux-kernel@vger.kernel.org, apiggyjj@yahoo.ca
Subject: Re: 'fd' file descriptor help
Message-ID: <20011206134519.A19511@figure1.int.wirex.com>
Mail-Followup-To: Nav Mundi <nmundi@karthika.com>,
	linux-kernel@vger.kernel.org, apiggyjj@yahoo.ca
In-Reply-To: <20011206211817.FAUB17034.tomts10-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206211817.FAUB17034.tomts10-srv.bellnexxia.net@there>; from nmundi@karthika.com on Thu, Dec 06, 2001 at 04:18:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nav Mundi (nmundi@karthika.com) wrote:
> Does anyone know what the file descriptor 'fd' pointer does?  My module makes 
> a system call [sys_open] to the kernal which then returns a fd value but I 
> don't know what this value means or how it gets it.  Does the fd value 
> signify a specific device or is it random?  Any ideas?

fd is a handle for the kernel file struct representing the file you
opened.  read include/linux/file.h::fd_install() to understand where
it's put, and include/linux/file.h::fcheck() as an example of retrieving
kernel object from the handle.

cheers,
-chris
