Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293678AbSCKKr1>; Mon, 11 Mar 2002 05:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293679AbSCKKrO>; Mon, 11 Mar 2002 05:47:14 -0500
Received: from ns.ithnet.com ([217.64.64.10]:46084 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S293678AbSCKKrH>;
	Mon, 11 Mar 2002 05:47:07 -0500
Date: Mon, 11 Mar 2002 11:46:54 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020311114654.2901890f.skraw@ithnet.com>
In-Reply-To: <20020311091458.A24600@namesys.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 09:14:58 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Mon, Mar 11, 2002 at 01:28:42AM +0100, Trond Myklebust wrote:
> >      > this is a weak try of an explanation. All involved fs types are
> >      > reiserfs. The problem occurs reproducably only after (and
> > Which ReiserFS format? Is it version 3.5?
> 
> >    'cat /proc/fs/reiserfs/device/version'
> 
> If this does not work because you have no such file, then look through your
> kernel logs, if you use reiserfs v3.5 on 2.4 kernel, it will show itself
> as such record in the log file: "reiserfs: using 3.5.x disk format"

Hello Oleg, hello Trond, hello Alan,

I have several reiserfs fs in use on this server. boot.msg looks like

<4>reiserfs: checking transaction log (device 08:03) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<4>Freeing unused kernel memory: 224k freed
<6>Adding Swap: 265032k swap-space (priority 42)
<4>reiserfs: checking transaction log (device 21:01) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 22:01) ...
<4>Using tea hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 08:04) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25

I tried to find out which device has which numbers and did a cat /proc/devices:

Block devices:
  2 fd
  8 sd
 11 sr
 22 ide1
 33 ide2
 34 ide3
 65 sd
 66 sd

Interestingly there is no #21. Shouldn't I see a block device 21 here?
More strange the only two existing ide-drives in this system are located on
ide2 and ide3 and should therefore have device numbers 33 and 34, or not?
There is no hd on ide1, only a CDROM (not used during the test). ide0 is
completely empty.
As told earlier this is kernel 2.4.19-pre2.

Enlighten me, please...

Stephan

