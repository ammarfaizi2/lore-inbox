Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSDFRdu>; Sat, 6 Apr 2002 12:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312638AbSDFRdt>; Sat, 6 Apr 2002 12:33:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13584 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312634AbSDFRdt>; Sat, 6 Apr 2002 12:33:49 -0500
Subject: Re: How to open files a process has mmapped
To: minyard@acm.org (Corey Minyard)
Date: Sat, 6 Apr 2002 18:50:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CADC998.9060501@acm.org> from "Corey Minyard" at Apr 05, 2002 09:58:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tuKm-0002Kp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a file a process has mmap-ed.  The trouble is that the file might be 
> deleted (this is actually likely in this scenario) so I can't just open 
> the file listed in /proc/<pid>/maps.

Well perhaps they should not have deleted it

> I have looked some at this, and I haven't come up with a good solution 
> for this.  I have come up with the following solutions:

You forgot fix the program to do sensible things. You can pass file handles
over AF_UNIX sockets for example, or you could rename the file so you can
find it then delete it later

> The last solution I could think of was to provide a way to open a file 
> with using the major/minor/inode (since these are listed for the mapped 
> files in the /proc/<pid>/maps file).  This is kind of ugly, but it's 
> probably the best one I've thought of.

Nice way to do security holes
