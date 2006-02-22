Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWBVPZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWBVPZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWBVPZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:25:45 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:53099 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751330AbWBVPZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:25:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=USZB232Z0T9oLb+CNiWVCSK55c2Ske/IZ88t2FdL7e/ggf2SFLsz3sfCvC/PWiENWHvT11Ca+FjmUOt4Is9ajqlvWRoEe0Xc8lFyG+31aQtmTBJdauBbDrrrXYJJuk017Nbw+FG52IV0ARmM960b0vOjlrwu/wa2p2BLPEkWZ9E=
Message-ID: <43FC8261.9000207@gmail.com>
Date: Wed, 22 Feb 2006 17:25:21 +0200
From: Yoav Etsion <etsman@gmail.com>
Reply-To: etsman@cs.huji.ac.il
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC: klogger: kernel tracing and logging tool 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This may look like a shameless plug, but it is intended as an RFC:
over the past few years I've developed a kernel logging tool called 
Klogger: http://www.cs.huji.ac.il/~etsman/klogger

In some senses, it is similar to the LTT - Linux Trace Toolkit (and was 
actually developed because LTT did not suit my needs).
However, Klogger is much more flexible. The two key points being:
1.
it offers extremely low logging overhead (better than LTT and Dtrace) by 
auto-generating the logging code from user-specified config files.
2.
it allows new events to be defined, and more importantly shared among 
subsystems' developers, thus allowing to understand module/subsystem 
interactions without an all encompassing knowledge.
This feature can allow developers to design the performance logging 
while designing the subsystem to be logged, allowing other 
developers/researchers to get some insights without having to fully 
understand a subsystem's code.

I am very interested in the community's opinion on this matter, so if 
anyone is interested you can find the design document, a HOWTO and 
patches against 2.6.14/2.6.9 on my website: 
http://www.cs.huji.ac.il/~etsman/klogger
or
http://linux-klogger.sf.net

Currently, we use this tool at the the Hebrew University, but if there 
is public interest I can work on it further so it adheres to kernel code 
standards (the tool currently does obscene things like writing to disk 
from kernel threads :-P --- it was written before relayfs was out there).

Thanks,

Yoav Etsion
