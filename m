Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264840AbRFTMca>; Wed, 20 Jun 2001 08:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264850AbRFTMcU>; Wed, 20 Jun 2001 08:32:20 -0400
Received: from c012-h008.c012.sfo.cp.net ([209.228.13.102]:35826 "HELO
	c012.sfo.cp.net") by vger.kernel.org with SMTP id <S264840AbRFTMcD>;
	Wed, 20 Jun 2001 08:32:03 -0400
Date: 20 Jun 2001 05:32:01 -0700
Message-ID: <20010620123201.14861.cpmta@c012.sfo.cp.net>
X-Sent: 20 Jun 2001 12:32:01 GMT
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
To: schwab@suse.de
From: Ralph Jones <ralph.jones@altavista.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Web Mail 3.9.3.1
Subject: Re: pivot_root from non-interactive script
X-Sent-From: ralph.jones@altavista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was using ash from SuSE 7.1 (ash-0.2-294)

I patched ash's input.c with 

fcntl(fd, F_SETFD, FD_CLOEXEC); in setinputd.  This fixed the problem.  

Then I found that there is version 0.3.5-11 (on the debian site) with this fix already included.  

Thanks for your help.

Ralph Jones


On Tue, 19 June 2001, Andreas Schwab wrote:

> 
> Ralph Jones <ralph.jones@altavista.com> writes:
> 
> |> Thanks.  Yes it looks as if this might be the case.  Do you have any ideas how I might get around this?  Or do I have to use a different shell?
> 
> The latter is probably the easiest.  Or fix /bin/ash to set FD_CLOEXEC on
> the file descriptor.
> 
> Andreas.
> 
> -- 
> Andreas Schwab                                  "And now for something
> SuSE Labs                                        completely different."
> Andreas.Schwab@suse.de
> SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
> Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5


Find the best deals on the web at AltaVista Shopping!
http://www.shopping.altavista.com
