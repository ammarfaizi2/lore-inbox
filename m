Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUFKTKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUFKTKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 15:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUFKTKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 15:10:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:39628 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264305AbUFKTKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 15:10:07 -0400
To: <viro@parcelfarce.linux.theplanet.co.uk>
Subject: =?iso-8859-1?Q?Re:_[PATCH]_sparse:___user_annotations_for_ipc_compat_code?=
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>,
       =?iso-8859-1?Q?Andrew_Morton?= <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Message-Id: <26879984$108698065040ca022a55e329.53154070@config18.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Fri, 11 Jun 2004 21:10:01 +0200
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro@parcelfarce.linux.theplanet.co.uk schrieb am 11.06.2004, 20:31:20:
> On Fri, Jun 11, 2004 at 05:27:30PM +0200, Arnd Bergmann wrote:

> >  	old_fs = get_fs();
> >  	set_fs(KERNEL_DS);
> > -	err = sys_msgsnd(first, p, second, third);
> > +	err = sys_msgsnd(first, (struct msgbuf __user *)p, second, third);
> >  	set_fs(old_fs);
> 
> Again, makes no sense whatsoever (we _still_ get a warning and clear fix
> would be to get rid of set_fs() here and switch to compat_alloc_user_space()).
> 
> Same goes for the rest of patch.
> 
> Folks, warnings are not personal performance metrics, they are tools for
> finding bogus code.  Sigh...

Ok, makes sense. I thought it was ok after I saw the same thing
done for kernel/compat.c in

http://linux.bkbits.net:8080/linux-2.5/gnupatch@40c10d10xahL03pX3RX14VzG8Qh1mw

      Arnd <><
