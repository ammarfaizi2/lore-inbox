Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVD1Tak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVD1Tak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVD1Taj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:30:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46020 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262245AbVD1TaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:30:06 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DR312-0005IZ-00@dorka.pomaz.szeredi.hu>
References: <20050426094727.GA30379@infradead.org>
	 <20050426131943.GC2226@openzaurus.ucw.cz>
	 <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
	 <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
	 <20050427143126.GB1957@mail.shareable.org>
	 <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
	 <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
	 <20050427155022.GR4431@marowsky-bree.de>
	 <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu>
	 <1114623598.4480.181.camel@localhost>
	 <E1DQqdW-0002SN-00@dorka.pomaz.szeredi.hu>
	 <1114624541.4480.187.camel@localhost>
	 <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu>
	 <1114630811.4180.20.camel@localhost>
	 <E1DQskk-0004dI-00@dorka.pomaz.szeredi.hu>
	 <1114637883.4180.55.camel@localhost>
	 <E1DR312-0005IZ-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114716602.4180.701.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 28 Apr 2005 12:30:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 00:00, Miklos Szeredi wrote:
> > ok. Generally overmounts are done on the root dentry of the topmost
> > vfsmount.  But in this case, your patch mounts it on the same dentry
> > as that of the private mount.
> > 
> > Essentially I was always under the assertion that 'a dentry can hold
> > only one vfsmount'.  But invisible mount seem to invalidate that
> > assertion.
> 
> You can do that without an invisible mount:
> 
> mkdir /tmp/mnt
> mkdir /tmp/dir1
> mkdir /tmp/dir1/subdir1
> mkdir /tmp/dir2
> mkdir /tmp/dir2/subdir2
> 
> cd /tmp/mnt
> mount --bind /tmp/dir1 .
> mount --bind /tmp/dir2 .
> 
> Now you have both /tmp/dir1 and /tmp/dir2 rooted at the same dentry.

Ok. got it!. Agreed. great example!

Thanks,
RP

