Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313265AbSDJP4M>; Wed, 10 Apr 2002 11:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313280AbSDJP4L>; Wed, 10 Apr 2002 11:56:11 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18157 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313265AbSDJP4K>; Wed, 10 Apr 2002 11:56:10 -0400
Message-ID: <3CB4606F.87A4460A@us.ibm.com>
Date: Wed, 10 Apr 2002 08:55:27 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Event logging vs enhancing printk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Holzheu wrote...
> I think it would be important to have both options:
> feed printk messages into posix event logging (this does
> the current patch as far as I know) 

The current patch forks the message to evlog inside the printk
function.  This thread is proposing that the printk function be
wrapped inside a macro so you could easily capture 
file/funcname/lineno of the calling function along with the
original printk message
(plus the other stuff stored in the evlog record header).
 
> AND feed events
> which are written with the new posix event APIs into the
> traditional syslogd logging.

This would be done in user-space, not in the kernel.  This is on
our enhancements list for event logging.
