Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318988AbSHMRuP>; Tue, 13 Aug 2002 13:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318989AbSHMRuP>; Tue, 13 Aug 2002 13:50:15 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:2800 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318988AbSHMRuN>; Tue, 13 Aug 2002 13:50:13 -0400
Date: Tue, 13 Aug 2002 13:54:05 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: klibc and logging
Message-ID: <20020813135405.A12730@redhat.com>
References: <3D58B14A.5080500@zytor.com> <ajaka7$qb6$1@ncc1701.cistron.net> <ajbgbf$7e7$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ajbgbf$7e7$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Aug 13, 2002 at 10:41:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 10:41:03AM -0700, H. Peter Anvin wrote:
> Requires too much to work before it's can be made available.
> 
> Andrew Morton sent me a proposed patch last night which adds a klogctl
> (a.k.a. sys_syslog) which does a printk() from userspace.  It was less
> than 10 lines; i.e. probably worth it.  I have hooked this up to
> syslog(3) in klibc, although the code is not checked in yet.

Rather, why not have the file descriptor early userspace gets called 
with point to a file that printk's whatever is written to it?  That 
makes more sense as the early init stuff really should end up in the 
kernel's log buffer.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
