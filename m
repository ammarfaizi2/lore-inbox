Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272137AbRI0Iwv>; Thu, 27 Sep 2001 04:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRI0Iwl>; Thu, 27 Sep 2001 04:52:41 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22290 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272137AbRI0IwV>; Thu, 27 Sep 2001 04:52:21 -0400
Date: Thu, 27 Sep 2001 10:52:47 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Norbert Sendetzky <norbert@linuxnetworks.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Implementing a new network based file system
Message-ID: <20010927105247.A32134@artax.karlin.mff.cuni.cz>
In-Reply-To: <200109211609.SAA08383@post.webmailer.de> <20010924142733.A7427@cs.cmu.edu> <20010925193432.A4005@vagabond> <200109261459.QAA08189@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109261459.QAA08189@post.webmailer.de>; from norbert@linuxnetworks.de on Wed, Sep 26, 2001 at 04:58:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Harkes mentioned that getattr() don't have to be implemented (and 
> isn't implemented by nfs, smbfs and coda). Where do the VFS knows 
> about the attributes the users see? I haven't found any function in 
> inode_operation which gets a struct iattr* as parameter except 
> getattr() and setattr().
 
It should use getattr, but it merely reads them directly from the
inode structure. You just have to keep it up-to-date

> I suppose readpage() is handled in the same way. What about syncpage?

Readpage is is similar, except there's nothing like prepare and commit read.

I have not understood syncpage yet. Maybe someone else could elighten this bit.

> I have another question about the file_operations: How is locking 
> (file locking => file_operations->lock()) done by the VFS. I've read 
> about there is a flag in the inode structure which is set by flock(). 
> But this lock isn't known by the server. Is file_operations->lock() 
> called when defined?

Have not get to this yet either.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
