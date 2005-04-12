Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVDLQEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVDLQEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVDLQAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:00:41 -0400
Received: from mail.shareable.org ([81.29.64.88]:19616 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262344AbVDLP4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:56:49 -0400
Date: Tue, 12 Apr 2005 16:56:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, dan@debian.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412155633.GG10995@mail.shareable.org>
References: <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411214123.GF32535@mail.shareable.org> <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu> <20050412143347.GC10995@mail.shareable.org> <425BE64B.7040801@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425BE64B.7040801@tuxrocks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson wrote:
> > That does not make sense.
> > 
> > Are you saying you cannot trust your own sshfs userspace daemon?
> 
> The user who wrote the userspace code may be able to, but the system
> shouldn't trust the userspace daemon.  Permissions will be enforced by
> the ssh server.

In fact that's wrong.  Although permissions are enforced by the ssh
server, the server assumes that once a conncection is established, all
requests on it are from the same originating user.  The server is not
able to check which user is accessing the files on the client machine
- which is why Miklos wants/needs restrictive permissions on the
client machine too.

-- Jamie
