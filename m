Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937824AbWLGAIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937824AbWLGAIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937825AbWLGAIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:08:01 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:34239 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937824AbWLGAIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:08:00 -0500
Message-ID: <1165451785.45776209dee2a@imp3-g19.free.fr>
Date: Thu, 07 Dec 2006 01:36:25 +0100
From: Remi Colinet <remi.colinet@free.fr>
To: Stephen Torri <storri@torri.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Obtaining a list of memory address ranges allocated to processes
References: <1165449386.13079.30.camel@base.torri.org>
In-Reply-To: <1165449386.13079.30.camel@base.torri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 82.216.7.132
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Stephen Torri <storri@torri.org>:

> I am trying to create a custom ELF and Windows PE loader for the purpose
> of security research. I am having a difficult time finding how to
> allocate memory for a binary at the desired address in memory
> (especially if its non-relocatable).

Use mmap system call.
Anyway, the address is only going to be a hint.

> I would like to see why I cannot
> get memory allocated at the exact address request in the binary headers.

address should be page aligned.

> Is there a program or system call that allows me to see a list of memory
> address ranges allocated to the running processes on a system?
>

pmap pid_of_your_program will give you the memory map.

> Stephen
>

Remi

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


