Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132955AbRDJHv7>; Tue, 10 Apr 2001 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132958AbRDJHvt>; Tue, 10 Apr 2001 03:51:49 -0400
Received: from ki.yok.utu.fi ([130.232.129.100]:64144 "HELO ki")
	by vger.kernel.org with SMTP id <S132955AbRDJHvp>;
	Tue, 10 Apr 2001 03:51:45 -0400
From: Tommi Virtanen <tv-nospam-32a552@debian.org>
To: chip@valinux.com (Chip Salzenberg)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt)
In-Reply-To: <E14jdkF-0007Ps-00@tytlal> <E14kAK3-0008UM-00@tytlal>
X-Attribution: Tv
X-URL: <http://tv.debian.net/>
Date: 10 Apr 2001 10:51:40 +0300
In-Reply-To: <E14kAK3-0008UM-00@tytlal>
Message-ID: <87snjh6vlf.fsf@ki.yok.utu.fi>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chip@valinux.com (Chip Salzenberg) writes:

> AFAIK, Alex Viro's idea of bindable namespaces provides effective
> transaction support *ONLY* if there are per-process bindings.  With
> per-process bindings, each client that opens a connection does so
> through a distinct binding; when that client's responses go back
> through the same binding, only that client can see them.

	Not really. We can both open /proc/partitions, read one char at a
        time, and the kernel won't confuse our read positions. Different
        file opens create different instances of state. See struct file,
        void *private_data for how to store arbitrary data.

-- 
tv@{{hq.yok.utu,havoc,gaeshido}.fi,{debian,wanderer}.org,stonesoft.com}
unix, linux, debian, networks, security, | First snow, then silence.
kernel, TCP/IP, C, perl, free software,  | This thousand dollar screen dies
mail, www, sw devel, unix admin, hacks.  | so beautifully.
