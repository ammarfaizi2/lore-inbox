Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbSJFRD5>; Sun, 6 Oct 2002 13:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261716AbSJFRD5>; Sun, 6 Oct 2002 13:03:57 -0400
Received: from flaske.stud.ntnu.no ([129.241.56.72]:30921 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S261708AbSJFRD4>; Sun, 6 Oct 2002 13:03:56 -0400
Date: Sun, 6 Oct 2002 19:09:32 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
       jw schultz <jw@pegasys.ws>
Cc: nfs@lists.sourceforge.net
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006170932.GA23134@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no> <20021006021802.GA31878@pegasys.ws> <1033871869.1247.4397.camel@phantasy> <20021006024902.GB31878@pegasys.ws> <20021006105917.GB13046@stud.ntnu.no> <20021006122415.GE31878@pegasys.ws> <20021006143636.GA30441@stud.ntnu.no> <20021006164228.GB17170@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006164228.GB17170@vagabond>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec:
> If the shares were successfuly reloaded, then the processes should wake
> up. If they don't, it's a bug in NFS.

They never wake up, and it happens every time.

> Try to reproduce it (ie. reboot some machine, let it start everything
> and then restart the autofsd and see if processes lock up) and then talk
> to NFS maintainers about that.

As I said above, it happens every time we encounter this, ie. it's a bug
that easy to reproduce (since I added nfs@lists.sourceforge.net to the
CC-list, I'm going to write some of what's already said in this thread).

Problem:
Processes entering D-state is unkillable. We have a problem with this 
everytime we restart autofs (which automounts quite a few NFS-shares
on campus), ie. on our samba-boxes smbd hangs forever after this
(in D-state). Samba still works, it's just that all the D-state processes
is unkillable and will remain that way untill we reboot the computer.
Every D-state process increases the load on the machine, and one of our
2-CPU intel-boxes currently remains at 430 (which extremly high for such
a box).

Solution:
? :)

-- 
Thomas
