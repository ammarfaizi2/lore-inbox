Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVEYSdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVEYSdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVEYSbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:31:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9912 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262367AbVEYS0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:26:54 -0400
Date: Wed, 25 May 2005 19:26:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proper API for sched_setaffinity ?
Message-ID: <20050525182651.GA25833@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
References: <4294BAD8.4030300@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4294BAD8.4030300@nortel.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 11:50:16AM -0600, Chris Friesen wrote:
> On my system (Mandrake 10.0) the man page for sched_setaffinity() lists 
> the prototype as:
> 
> int  sched_setaffinity(pid_t  pid,  unsigned  int  len,  unsigned  long
>        *mask);
> 
> 
> But /usr/include/sched.h gives it as
> 
> extern int sched_setaffinity (__pid_t __pid, __const cpu_set_t *__mask)
> 
> Which is correct?

The first is the syscall, the second is an API glibc folks invented and put
into libc while beeing on crack.

