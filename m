Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWIAQIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWIAQIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWIAQIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:08:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:59330 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932146AbWIAQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:08:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mgfEj4gEKLnuTufoTy+Mm6rDrNUNL+3ljwI5mx9/PebrC3mY3uGsAIV+M91nzFzpPdCbLtqDFFUM+MQrVtPyvYUjKXw9BIKQjjCwTmkYELkvNdEkPVFR+dyu2V0VPglEpigb+TW9dbnMu26PXVi6kHXu8YFyhH2efPKLXvggIKg=
Message-ID: <76bd70e30609010908n47eb356ob121109961f8221c@mail.gmail.com>
Date: Fri, 1 Sep 2006 12:08:14 -0400
From: "Chuck Lever" <chucklever@gmail.com>
To: "Olaf Kirch" <okir@suse.de>
Subject: Re: [NFS] [PATCH 019 of 19] knfsd: Register all RPC programs with portmapper by default
Cc: NeilBrown <neilb@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060901155407.GC29574@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060901141639.27206.patches@notabene>
	 <1060901043948.27677@suse.de>
	 <76bd70e30609010831m9e80cfav514d60718d35e7d5@mail.gmail.com>
	 <20060901155407.GC29574@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/06, Olaf Kirch <okir@suse.de> wrote:
> On Fri, Sep 01, 2006 at 11:31:25AM -0400, Chuck Lever wrote:
> > I don't like this.  The idea that multiple RPC services are listening
> > on the same port is a total hack.  What other service might use this
> > besides NFSACL?
>
> Why do you consider this a hack? I have always felt that librpc requiring
> you to open separate ports for every program you register was a poor
> design. The RPC header contains the program number, and the RPC code
> is fully capable of demuxing incoming requests. So I do not think it is
> a hack at all.
>
> And yes, Solaris NFSACL resides on 2049 too.

I meant "Does Solaris advertise NFSACL on 2049 via the portmapper?"

-- 
"We who cut mere stones must always be envisioning cathedrals"
   -- Quarry worker's creed
