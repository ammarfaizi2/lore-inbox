Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVCPP7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVCPP7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVCPP7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:59:19 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:37815 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262632AbVCPP7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:59:15 -0500
Message-ID: <423857D3.80609@cosmosbay.com>
Date: Wed, 16 Mar 2005 16:59:15 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: regatta <regatta@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 32Bit vs 64Bit
References: <5a3ed5650503160744730b7db4@mail.gmail.com>
In-Reply-To: <5a3ed5650503160744730b7db4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 16 Mar 2005 16:59:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

regatta wrote:

> Hi everyone,
> 
> I have a question about the 64Bit mode in AMD 64bit
> 
> My question is if I run a 32Bit application in Optreon AMD 64Bit with
> Linux 64Bit does this give my any benefit ? I mean running 32Bit
> application in 64Bit machine with 64 Linux is it better that running
> it in 32Bit or doesn't make any different at all ?
> 
> Thanks

Hi

Running a 32 bits application on a x86_64 kernel gives more virtual 
address : 4GB of user memory, instead of 3GB on a standard 32bits kernel

If your application uses a lot of in-kernel ressources (like tcp 
sockets and network buffers), it also wont be constrained by the 
pressure a 32 bits kernel has on lowmem (typically 896 MB of lowmem)

If your machine has less than 2GB, running a 64bits kernel is not a 
win, because all kernel data use more ram (pointers are 64 bits 
instead of 32bits)

Eric

