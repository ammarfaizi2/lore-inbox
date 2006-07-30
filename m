Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWG3PXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWG3PXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWG3PXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:23:54 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:49164 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932337AbWG3PXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:23:53 -0400
Message-ID: <44CCCF06.4070406@argo.co.il>
Date: Sun, 30 Jul 2006 18:23:50 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <44CCCB74.9010605@gmail.com>
In-Reply-To: <44CCCB74.9010605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2006 15:23:51.0859 (UTC) FILETIME=[299F3030:01C6B3EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>
> > unfortunately this only works for MMX not for real fpu (due to 
> exception
> > handling uglies)
>
> concludes it's not multiplatform at all... For that reasen I (maybe) 
> want some
> "protocol" for communication with US, where I can easily compute it.
>
Well, usually such a protocol is by means of read(2) and write(2) to a 
character device provided by your driver: userspace reads some data, 
does the fp ops, and writes it back.  If you want realtime you'll have 
to use a realtime thread with the appropriate priority.

-- 
error compiling committee.c: too many arguments to function

