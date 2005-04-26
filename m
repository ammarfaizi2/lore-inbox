Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVDZPBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVDZPBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDZPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:01:49 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:58629 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261546AbVDZPBp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:01:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p73oCTtbeVtc3UwmyFguO39/mGTHpn3qu7KjcCSH+saS7pedf1F6+f2ngaiRpr1gj7IjGMRYsUOABjxIr5REJL/Ua1gPGQvsbUawPjvgX87HU7ZJdo4mNkzIt86likPcgM0U+eR1KNIVhErYVOXUcdv/sVxvTJnVvPhB4YLfn9g=
Message-ID: <a4e6962a05042608013534505a@mail.gmail.com>
Date: Tue, 26 Apr 2005 10:01:45 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] private mounts
Cc: hch@infradead.org, akpm@osdl.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1DQQpD-0000dL-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114445923.4480.94.camel@localhost>
	 <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu>
	 <20050426093628.GA30208@infradead.org>
	 <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu>
	 <20050426030010.63757c8c.akpm@osdl.org>
	 <20050426100412.GA30762@infradead.org>
	 <20050426031414.260568b5.akpm@osdl.org>
	 <20050426103859.GA31468@infradead.org>
	 <a4e6962a05042606053c1e6ba8@mail.gmail.com>
	 <E1DQQpD-0000dL-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > that complicates things a great deal, however -- if you split the
> > concept of "srv points" from file system mounts and remount the file
> > system (perhaps automatically as part of initiating the session) for
> > every new login -- then you can revalidate security at each of these
> > mounts.
> 
> Why would you have to revalidate?  A simple bind mount would suffice.
> However, joining another sessions namespace makes more sense, than
> copying the mounts individually.
> 

Well, the forced revalidation was an attempt to protect "user-data"
from root, which, as you pointed out in your reply, is a somewhat
sketchy thing.  It may also be useful if you wish to share a
filesystem/namespace with a subset of users with a permissions model
outside of the normal user/groups model (which the user doesn't really
have any control over).

Anyways, just an additional idea for consideration -- as I said, I
don't really feel a strong need for this, so perhaps its best
forgotten for now.

          -eric
