Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbUC2Ds1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 22:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUC2Ds1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 22:48:27 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:29578 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262584AbUC2DsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 22:48:25 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 28 Mar 2004 19:48:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ivan Godard <igodard@pacbell.net>
cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel support for peer-to-peer protection models...
In-Reply-To: <07df01c4153c$8b5a79c0$fc82c23f@pc21>
Message-ID: <Pine.LNX.4.44.0403281946240.12828-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Ivan Godard wrote:

> ----- Original Message ----- 
> From: "Paul Mackerras" <paulus@samba.org>
> To: "Ivan Godard" <igodard@pacbell.net>
> Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
> Sent: Sunday, March 28, 2004 4:17 PM
> Subject: Re: Kernel support for peer-to-peer protection models...
> 
> 
> > Ivan Godard writes:
> >
> > > 3) flat, unified virtual addresses (64 bit) so that pointers, including
> > > inter-space pointers, have the same representation in all spaces
> >
> > How are you going to implement fork() ?
> 
> The usual COW using the page tables. The child keeps the same code space but
> gets a new data space. I expect that specialized versions of fork will give
> explicit control over which space the child gets, but in comman usage no one
> cases just as no one cares which PID it gets.

Uh?

int myexec(char const *cmd) {

	if (!fork()) {
		exit(exec(cmd));
	}
	...
}



- Davide


