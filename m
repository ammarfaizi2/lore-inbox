Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVEPVfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVEPVfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVEPVeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:34:25 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:26636 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261896AbVEPVeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:34:10 -0400
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
	<428898CF.5060908@cosmosbay.com>
	<6.2.1.2.2.20050516151659.077cceb0@mail.tekno-soft.it>
	<4288AB6A.3060106@cosmosbay.com>
	<6.2.1.2.2.20050516164236.05922a30@mail.tekno-soft.it>
From: Nix <nix@esperi.org.uk>
X-Emacs: anything free is worth what you paid for it.
Date: Mon, 16 May 2005 22:34:00 +0100
In-Reply-To: <6.2.1.2.2.20050516164236.05922a30@mail.tekno-soft.it> (Roberto
 Fichera's message of "16 May 2005 15:54:37 +0100")
Message-ID: <87hdh2am9j.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2005, Roberto Fichera whispered secretively:
> At 16.17 16/05/2005, Eric Dumazet wrote:
>>If your process is cpu bounded (and not issuing too many system calls),
>> then 4GB/4GB split let it address more ram, reducing the need to shift windows in
>>mmaped files for example.
> 
> ... any source code that explain better what you say ;-)!

<http://lkml.org/lkml/2003/7/8/246> perhaps?

(In a nutshell: it gives processes an extra 1Gb of virtual memory, at
the cost of making system calls --- and everything else that must
transition to kernel space --- *much* slower.)
