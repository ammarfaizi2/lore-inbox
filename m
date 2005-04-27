Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVD0R7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVD0R7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVD0R5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:57:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30122 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261852AbVD0Rzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:55:48 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DQqdW-0002SN-00@dorka.pomaz.szeredi.hu>
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
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114624541.4480.187.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 27 Apr 2005 10:55:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 10:47, Miklos Szeredi wrote:
> > I think you need to disallow overmounts on invisible mounts by any user
> > other than the owner. If not, some other user (including root) can
> > overmount on your mount and the user will end up with DoS.
> 
> I'm not following you here.  How would an overmount cause DoS?

eg:
 
user 1 does a invisible mount on /mnt/mnt1
root does a visible mount on /mnt/mnt1

user 1 will no longer be able to access his /mnt/mnt1

in fact even if root mounts something on /mnt, the problem still exists.

RP

> 
> Thanks,
> Miklos

