Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTAJRy5>; Fri, 10 Jan 2003 12:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTAJRy4>; Fri, 10 Jan 2003 12:54:56 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:55763 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S265469AbTAJRy4>;
	Fri, 10 Jan 2003 12:54:56 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 10 Jan 2003 19:03:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: How build dependencies work/are supposed to work in 2.5
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <CD9EA6E65DF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 03 at 18:35, Sam Ravnborg wrote:
> On Thu, Jan 09, 2003 at 11:33:32PM +0100, Petr Vandrovec wrote:
> >   So I'd like to ask whether current kernel build system is supposed
> > to track changes in include files automagically, or whether I'm supposed
> > to run 'make dep' from time to time?
> 
> Until now I'm only aware of one set of problems that kbuild does not
> handle correct. That is when the timestamp of the files goes backward.
> This happens at least in the following situations:
> 1) A file is saved, and mv is used to restore the original
> 2) CVS is configured to preserve original timestamp when files are 'dumped'
> 3) NFS mounted filesystems where the clock is wrong. Timezone
>    inconsistency for eaxmple.
> 
> I assume you were hit by some flavour of 1) ???

Thanks for your explanation. After I was thinking about it, you are 
probably right. Maybe that I just copied console_struct.h from 
distribution kernel instead of reverting patch to get to the original
version, and I forgot touching file.

Sorry for confusion.
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
