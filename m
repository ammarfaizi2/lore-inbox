Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291782AbSBNQrr>; Thu, 14 Feb 2002 11:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291781AbSBNQrV>; Thu, 14 Feb 2002 11:47:21 -0500
Received: from ns.suse.de ([213.95.15.193]:11789 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291784AbSBNQrC>;
	Thu, 14 Feb 2002 11:47:02 -0500
To: Michael Sinz <msinz@wgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <3C6BE18F.7B849129@wgate.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Feb 2002 17:37:46 +0100
In-Reply-To: Michael Sinz's message of "14 Feb 2002 17:15:32 +0100"
Message-ID: <p73lmdw10kl.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Sinz <msinz@wgate.com> writes:
> 
> This then causes core dumps to be of the format:
> 
>         /coredumps/whale.sinz.org-badprogram-13917.core

I had something like this for a long time on my todo list. The idea
was to set core_name_format to the name of a named pipe and have an 
daemon on the other end that logs backtraces to syslogd (something a 
bit like dr.watson) 
Only problem is that it won't handle parallel coredumps very well
without some additional (deadlock prone) global locking or alternatively 
support AF_UNIX stream sockets too that have the concept of multiple 
streams over a single name. 

-Andi
