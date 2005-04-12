Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVDLPOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVDLPOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVDLPOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:14:31 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:62686 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262466AbVDLPNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:13:44 -0400
To: jamie@shareable.org
CC: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412143347.GC10995@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 15:33:47 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411214123.GF32535@mail.shareable.org> <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu> <20050412143347.GC10995@mail.shareable.org>
Message-Id: <E1DLN54-0001nO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 17:13:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > With that, the desire for virtual filesystems which cannot be read
> > > by your sysadmin (by accident) is easy to satisfy - and that kind of
> > > mechanism would probably be acceptable to all.
> > 
> > The problem is that this way the responsibility goes to the userspace
> > program, which can't be trusted.
> 
> That does not make sense.
> 
> Are you saying you cannot trust your own sshfs userspace daemon?

OK, I was not clear here.  When I say it cannot be trusted I'm in my
sysadmin cap, not my user cap.

Hiding the mountpoint from root has dual purpose:

  1) Sysadmin won't accidentaly spy on user's private files

  2) User can't confuse sysadmin deliberately, by creating a
     filesystem containing files he otherwise wouldn't be able to
     create

For 1) your porposal makes sense, however for 2) it's useless, since
now the user doesn't want the hiding.

Miklos
