Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSHCLOF>; Sat, 3 Aug 2002 07:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSHCLOF>; Sat, 3 Aug 2002 07:14:05 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:53252 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317517AbSHCLOE>;
	Sat, 3 Aug 2002 07:14:04 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition? 
In-reply-to: Your message of "Sat, 03 Aug 2002 21:07:11 +1000."
             <2020.1028372831@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 21:17:23 +1000
Message-ID: <2324.1028373443@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Aug 2002 21:07:11 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>On Sat, 3 Aug 2002 12:08:28 +0200, 
>Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> wrote:
>>Anyway this code can corrupt the global variable nr_threads.
>>Without the BKL it is buggy, so it has to be fixed anyway and we
>>can do it right.
>
>nr_threads is protected by tasklist_lock.  How on earth can fuzzy
>counting on user->processes corrupt nr_threads?

Never mind.  Checking and updating nr_threads is a seperate race from
the one on user->processes.  The nr_threads race is a problem that
needs to be fixed.

