Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281846AbRLDViK>; Tue, 4 Dec 2001 16:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283475AbRLDViA>; Tue, 4 Dec 2001 16:38:00 -0500
Received: from mailout.nordcom.net ([213.168.202.90]:689 "HELO
	mailout.nordcom.net") by vger.kernel.org with SMTP
	id <S281846AbRLDVhq>; Tue, 4 Dec 2001 16:37:46 -0500
Date: Tue, 4 Dec 2001 22:40:26 +0100
From: Roland Bauerschmidt <rb@debian.org>
To: linux-kernel@vger.kernel.org
Subject: virtual filesystem with data managed in userspace
Message-ID: <20011204224026.A18753@g>
Mail-Followup-To: Roland Bauerschmidt <rb@debian.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for a science project I'm thinking about writing a virtual filesystem
driver that provides access to data that is managed in userspace. I'm
quite new to Kernel hacking, so I'd be glad if someone could provide
some tips about the design, especially the data exchange between kernel-
and userspace. The scenario looks like this:

/foo is type my_virtual_fs_to_be_written

If somebody reads let's say /foo/bar, the kernel module communicates in
some way with a daemon (or something) in userspace that provides the
nessary information (data) to the kernel module which then uses it
to return the necessary information to the application that tries to
read data.

Do you think this concept is workable at all? What I am most worried
about is the communication between user and kernel space since
eventually quite an amount of information (file contents) would need be
exchanged. High performance is not really critical here, though. How
could this be done best? I thought about a character device (FIFO)
through which kernel module and userspace daemon would exchange
commands and data in a defined way, similar to some network protocol
standard like HTTP.

It'd be very happy about any suggestions or tips,

	Roland

-- 
Roland Bauerschmidt
