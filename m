Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284153AbRLKXF7>; Tue, 11 Dec 2001 18:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284175AbRLKXFt>; Tue, 11 Dec 2001 18:05:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33287 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284178AbRLKXFi>; Tue, 11 Dec 2001 18:05:38 -0500
Subject: Re: Linux 2.4.17-pre5
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 11 Dec 2001 23:14:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
        anton@samba.org, davej@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <m1ofl6uo60.fsf@frodo.biederman.org> from "Eric W. Biederman" at Dec 11, 2001 02:00:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Dw6c-0007IB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually we don't do a 1:1 physical to logical mapping.  I currently
> have a board that has physical id's of:  0:6 and logical id's of 0:1
> with no changes to the current x86 code. 

I mistook the physical to apic ones. My fault

/*
 * On x86 all CPUs are mapped 1:1 to the APIC space.
 * This simplifies scheduling and IPI sending and
 * compresses data structures.
 */
static inline int cpu_logical_map(int cpu)
{
        return cpu;
}
static inline int cpu_number_map(int cpu)
{
        return cpu;
}
