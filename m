Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275380AbSITXmf>; Fri, 20 Sep 2002 19:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbSITXmf>; Fri, 20 Sep 2002 19:42:35 -0400
Received: from ns.suse.de ([213.95.15.193]:34314 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S275380AbSITXme>;
	Fri, 20 Sep 2002 19:42:34 -0400
Date: Sat, 21 Sep 2002 01:47:35 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, msinz@wgate.com
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
Message-ID: <20020921014735.A28162@wotan.suse.de>
References: <3D8B87C7.7040106@wgate.com.suse.lists.linux.kernel> <3D8B8CAB.103C6CB8@digeo.com.suse.lists.linux.kernel> <3D8B934A.1060900@wgate.com.suse.lists.linux.kernel> <3D8B982A.2ABAA64C@digeo.com.suse.lists.linux.kernel> <p73bs6stfv8.fsf@oldwotan.suse.de> <3D8BAEDC.ED943632@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8BAEDC.ED943632@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 04:27:24PM -0700, Andrew Morton wrote:
> Andi Kleen wrote:
> > 
> > Andrew Morton <akpm@digeo.com> writes:
> > 
> > > True, but it's all more code and I don't believe that it adds
> > > much value.  It means that people need to run off and find
> > 
> > One useful feature of it would be that you can get core dumps for
> > each thread by including the pid (or tid later with newer threading libraries)
> > Currently threads when core dumping overwrite each others cores so you lose
> > the registers of all but one.
> 
> Oh sure, I agree that it's a useful feature.  But I don't agree that
> we need to allow users to specify how the final filename is pasted
> together.  Just give them host-uid-gid-comm.core.  ie: everything.

That wouldn't support the Dr.Watson thing.

-Andi
