Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVC3XrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVC3XrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVC3XrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:47:18 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:1646 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262602AbVC3Xqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:46:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KpxGbv0wLWE66toU/Iyg8zy5yp82xmMvVp5PA8tym742GxUGbH/m0qMO1yGHWNiT0BV9YXPxVBeFSAZwPdhKG51MLYL5A5L7ilVWwxurgxXWSrVjpRJ10YFZ+pxITxvljux/s7EzWs2slrkLF2keNL5PZo6C5f9DsCal3nuIlPM=
Message-ID: <6f6293f105033015467d87993@mail.gmail.com>
Date: Thu, 31 Mar 2005 01:46:39 +0200
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: 20050323135317.GA22959@roonstrasse.net
Subject: Re: forkbombing Linux distributions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050328172820.GA31571@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050328172820.GA31571@linux.ensimag.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 19:28:20 +0200, Matthieu Castet
<mat@ensilinx1.imag.fr> wrote:
> > The memory limits aren't good enough either: if you set them low
> > enough that memory-forkbombs are unperilous for
> > RLIMIT_NPROC*RLIMIT_DATA, it's probably too low for serious
> > applications.
> 
> yes, if you want to run application like openoffice.org you need at
> least 200Mo. If you want that your system is usable, you need at least 40 process per user. So 40*200 = 8Go, and it don't think you have all this memory...
> 
> I think per user limit could be a solution.
> 
> attached a small fork-memory bombing.

Doesn't do anything on my machine:

# ulimits -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
file size               (blocks, -f) unlimited
pending signals                 (-i) 4095
max locked memory       (kbytes, -l) 32
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 100
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

it tops at 100 processes and eats a little CPU... although the system
is under load, it's completely responsive.
