Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTDGWFs (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbTDGWFs (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:05:48 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:27654 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S263700AbTDGWFq convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 18:05:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] new syscall: flink
Date: Tue, 8 Apr 2003 00:17:21 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <200304072255.47254.fredrik@dolda2000.cjb.net> <3E91F0FD.1040507@redhat.com>
In-Reply-To: <3E91F0FD.1040507@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304080017.21799.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 23:43, Ulrich Drepper wrote:
> Fredrik Tolf wrote:
> > Anyway, while we're on the subject, is it just me who would like to see a
> > fexec() call?
>
> If you'd run an up-to-date system (e.g., RHL9) you'd have fexecve()
> already.

Am I right if I guess that this is the execve("/proc/self/fd/?") solution? I'm 
asking since I'm running 2.4.20 right now and I do not have such a syscall.
I'm not sure if I truly like the idea of having to rely on the existence of 
the proc fs, especially not since there is the chroot call. fexecve would 
also be a nice thing just because of that, since it allows you to keep a file 
descriptor over a chroot away from any /proc accessibility and then exec it.
For that reason, a fexec call could increase security in certain areas.

If I've missed the introduction of a fexecve syscall, I'm sorry for wasting 
your time.

Fredrik Tolf

