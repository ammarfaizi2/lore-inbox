Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318135AbSHNDyL>; Tue, 13 Aug 2002 23:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319183AbSHNDyK>; Tue, 13 Aug 2002 23:54:10 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:43768 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318135AbSHNDyK>; Tue, 13 Aug 2002 23:54:10 -0400
Date: Tue, 13 Aug 2002 23:58:03 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
Message-ID: <20020813235803.A15947@redhat.com>
References: <3D59CBFA.9CFC9FEE@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D59CBFA.9CFC9FEE@zip.com.au>; from akpm@zip.com.au on Tue, Aug 13, 2002 at 08:18:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 08:18:18PM -0700, Andrew Morton wrote:
> 
> The patch allows userspace to issue printk's, via sys_syslog():

This is an incredibly bad idea.  It has security hole written all over it.  
Any user can now spam the kernel's log ringbuffer and overrun potentially 
important messages.

		-ben
