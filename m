Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBPGlV>; Fri, 16 Feb 2001 01:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129375AbRBPGlL>; Fri, 16 Feb 2001 01:41:11 -0500
Received: from kamikazi.draper.net ([206.96.230.5]:43382 "EHLO
	kamikazi.draper.net") by vger.kernel.org with ESMTP
	id <S129197AbRBPGk7>; Fri, 16 Feb 2001 01:40:59 -0500
Date: Fri, 16 Feb 2001 00:42:07 -0600
From: kernel <kernel@draper.net>
To: Elena Labruna <labruna@cli.di.unipi.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: longjmp problem
Message-ID: <20010216004207.A2097@draper.net>
In-Reply-To: <Pine.LNX.4.21.0102120802270.3423-100000@delta19.cli.di.unipi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <Pine.LNX.4.21.0102120802270.3423-100000@delta19.cli.di.unipi.it>; from Elena Labruna on Mon, Feb 12, 2001 at 08:10:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 08:10:01AM +0100, Elena Labruna wrote:
> I'm working with a C package written by other
> on a linux machine with kernel version 2.2.14,
> often in a calls of longjmp routine
> the system crash with a SIGSEGV signal. 
>  
> Anyone can tell me if it can be a kernel problem ?
> 
> Elena Labruna.
> 

Fwiw, we issue(d) longjmp() in signal catching functions (including 
segv) without difficulty on 2.2.14 kernels.  Perhaps your application 
is not first calling setjmp() to save the stack context?

Reed,
