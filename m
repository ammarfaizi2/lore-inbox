Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSHBRKF>; Fri, 2 Aug 2002 13:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSHBRKF>; Fri, 2 Aug 2002 13:10:05 -0400
Received: from daimi.au.dk ([130.225.16.1]:3284 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316465AbSHBRKE>;
	Fri, 2 Aug 2002 13:10:04 -0400
Message-ID: <3D4ABDBA.35153981@daimi.au.dk>
Date: Fri, 02 Aug 2002 19:13:30 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition?
References: <3D4A8D45.49226E2B@daimi.au.dk> <200208021700.g72H0bm02654@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> Am Freitag, 2. August 2002 15:46 schrieb Kasper Dupont:
> > Is there a race condition in this piece of code from do_fork in
> 
> It would seem so. Perhaps the BKL was taken previously.

I guess you are right. Looking closer on the following lines
I find a comment stating that nr_threads is protected by the
kernel lock, but I don't see a lock_kernel() anywhere in this
code. How about the next code using the nr_threads variable,
is that safe?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
