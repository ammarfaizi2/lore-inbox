Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbVICPB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVICPB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVICPB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:01:56 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:3220 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750967AbVICPBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:01:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HU56B6yuN7WEbUJLD80cx99IL2cjHOGnUacXjdG4m/RN6CRHeSAYaGBERgpGXahEGz2mfMPg0ofxVKZPO4hzmbF3H5uAZtIzSJ/20xrqki4zek7Yq1jBYB1fEE9ulOsW74ECklfEEVn+oT/VRD1mXGKMAbDHf2RgPLNJlo2itd0=
Message-ID: <a4e6962a0509030801616dd011@mail.gmail.com>
Date: Sat, 3 Sep 2005 10:01:49 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: ericvh@gmail.com
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: FUSE merging?
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       fuse-devel@lists.sourceforge.net, v9fs-developer@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EBYsp-0007Sc-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
	 <20050902153440.309d41a5.akpm@osdl.org>
	 <E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a050903062941d46389@mail.gmail.com>
	 <E1EBYsp-0007Sc-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > While FUSE doesn't handle it directly, doesn't it have to punt it to
> > its network file systems, how to the sshfs and what not handle this
> > sort of mapping?
> 
> Sshfs handles it by not handling it.  In this case it is neither
> possible, nor needed to be able to correctly map the id space.
> 
> Yes, it may confuse the user.  It may even confuse the kernel for
> sticky directories(*).  But basically it just works, and is very
> simple.
> 

In principal, Plan 9 file servers handle permission checking
server-side, so we could likewise punt -- but it seemed a good idea to
have some form of mapping for directory listings (and things like
sticky directories) to make sense.

               -eric
