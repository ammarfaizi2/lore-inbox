Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTKJMIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 07:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTKJMIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 07:08:45 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:12016 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263277AbTKJMIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 07:08:43 -0500
Message-ID: <3FAF7FC8.8050503@softhome.net>
Date: Mon, 10 Nov 2003 13:08:40 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <QiyV.1k3.15@gated-at.bofh.it>
In-Reply-To: <QiyV.1k3.15@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   sendfile(2) - ?

Davide Rossetti wrote:
> it may be orribly RTFM... but writing a simple framework I realized 
> there is no libc/POSIX/whoknows
> copy(const char* dest_file_name, const char* src_file_name)
> 
> What is the technical reason???
> 
> I understand that there may be little space for kernel side 
> optimizations in this area but anyway I'm surprised I have to write
> 
> < the bits to clone the metadata of src_file_name on opening 
> dest_file_name >
> const int BUFSIZE = 1<<12;
> char buffer[BUFSIZE];
> int nrb;
> while((nrb = read(infd, buffer, BUFSIZE) != -1) {
>  ret = write(outfd, buffer, nrb);
>  if(ret != nrb) {...}
> }
> 
> instead of something similar to:
> sys_fscopy(...)
> 
> regards
> 


-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

