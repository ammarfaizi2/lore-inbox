Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSHQR1V>; Sat, 17 Aug 2002 13:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSHQR1V>; Sat, 17 Aug 2002 13:27:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3957 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318027AbSHQR1U>; Sat, 17 Aug 2002 13:27:20 -0400
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reduce stack usage of sanitize_e820_map
References: <20020815174825.F29874@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Aug 2002 11:18:11 -0600
In-Reply-To: <20020815174825.F29874@redhat.com>
Message-ID: <m11y8xqu98.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@redhat.com> writes:

> Hello,
> 
> Currently, sanitize_e820_map uses 0x738 bytes of stack.  The patch below 
> moves the arrays into __initdata, reducing stack usage to 0x34 bytes.

Can we keep the arrays in sanitize_e820_map and just mark then static
and __initdata?  That would appear to be a cleaner solution.   
Polluting the global kernel name space with these is not nice. 

Eric
