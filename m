Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbSJGHnY>; Mon, 7 Oct 2002 03:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSJGHnY>; Mon, 7 Oct 2002 03:43:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:6908 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262912AbSJGHnW>;
	Mon, 7 Oct 2002 03:43:22 -0400
Message-Id: <200210070731.g977VAp17211@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org, Thomas Lang?s <tlan@stud.ntnu.no>
Subject: Re: Unable to kill processes in D-state
Date: Mon, 7 Oct 2002 10:24:43 -0200
X-Mailer: KMail [version 1.3.2]
Cc: nfs@lists.sourceforge.net
References: <1033841462.1247.3716.camel@phantasy> <20021006164228.GB17170@vagabond> <20021006170932.GA23134@stud.ntnu.no>
In-Reply-To: <20021006170932.GA23134@stud.ntnu.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 October 2002 15:09, Thomas Lang?s wrote:
> Jan Hudec:
> > If the shares were successfuly reloaded, then the processes should
> > wake up. If they don't, it's a bug in NFS.
>
> They never wake up, and it happens every time.
>
> > Try to reproduce it (ie. reboot some machine, let it start
> > everything and then restart the autofsd and see if processes lock
> > up) and then talk to NFS maintainers about that.
>
> As I said above, it happens every time we encounter this, ie. it's a
> bug that easy to reproduce (since I added nfs@lists.sourceforge.net
> to the CC-list, I'm going to write some of what's already said in
> this thread).
>
> Problem:
> Processes entering D-state is unkillable. We have a problem with this
> everytime we restart autofs (which automounts quite a few NFS-shares
> on campus), ie. on our samba-boxes smbd hangs forever after this
> (in D-state). Samba still works, it's just that all the D-state
> processes is unkillable and will remain that way untill we reboot the
> computer. Every D-state process increases the load on the machine,
> and one of our 2-CPU intel-boxes currently remains at 430 (which
> extremly high for such a box).
>
> Solution:
> ? :)

Please provide info about:
* automounter startup options
* automounter configuration file(s)
* client/server kernel version and .config
* ksymoopsed SysRq-T dump of a couple of hung processes
  (no, not all processes! please select 2-5 hung processes _only_
  before feeding dump to ksymoops :-)
--
vda
