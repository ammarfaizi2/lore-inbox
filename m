Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVEKXBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVEKXBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVEKW7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:59:38 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:53560 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262059AbVEKW6l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:58:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=av3haCXP9Dku4YPaiY0VwqeU2ZHEDXUPpO1CqGJ7QlVrTKdrsEgUtk9J5znXJnLuzghNcI/k8cz5QPipl7AEsn8j1mW9FU+IF4TkKDkn+CNHU2x4R4NwnjXuW2TUrPdLTY80Mfa2qtNXNQJncHM8K977h+DJVKMsvvNI9PEBMsg=
Message-ID: <a4e6962a0505111558337dd903@mail.gmail.com>
Date: Wed, 11 May 2005 17:58:41 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Ram <linuxram@us.ibm.com>
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Cc: Jamie Lokier <jamie@shareable.org>, Miklos Szeredi <miklos@szeredi.hu>,
       7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <1115851333.6248.225.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <406SQ-5P9-5@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it>
	 <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it>
	 <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
	 <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Ram <linuxram@us.ibm.com> wrote:
> On Wed, 2005-05-11 at 14:28, Jamie Lokier wrote:
> > Ram wrote:
> 
> Well it makes it totally confusing. A user would start seeing different
> set of mounts suddenly as he changes directories beloning to different
> namespaces. I am not sure, if changing namespace implicitly is a good
> idea. Not saying its a bad idea, but seems to change my notion of
> namespaces completely.
> 
> I think a process should have access to one
> namespace at any given point in time, and should have the ability
> to explicitly switch to a different namespace of its choice, provided
> it has enough access permission to that namespace.
> 

I agree with Ram.  This whole recent flurry of activity seems to be
going down a path which will end in tears.  I think Miklos' patch for
allowing user mounts and Janak's patch were both more or less the
direction I'd like to see us moving.  Let's hold off on all these
freaky shared-namespace and passed-namespace semantics until we get
the basics in place and get some experience using them.

         -eric
