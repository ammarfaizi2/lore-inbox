Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbVJGR1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbVJGR1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVJGR1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:27:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030519AbVJGR1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:27:01 -0400
Message-ID: <4346AFD4.3000009@RedHat.com>
Date: Fri, 07 Oct 2005 13:26:44 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH] kNFSD - Allowing rpc.nfsd to setting of the port,
 transport and version the server will use
References: <43469FA7.7020908@RedHat.com> <20051007164435.GC9759@fieldses.org>
In-Reply-To: <20051007164435.GC9759@fieldses.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bruce,

J. Bruce Fields wrote:
>
> So the obvious question is what will happen if someone does
> 
> 	rpc.nfsd -N 3
> 
> on a server supporting 2, 3, and 4.
> 
> It looks like the code in svc_create() will set pg_lovers to 2 and
> pg_hivers to 4 in that case.  So if someone tries to use version 3, the
> error they get back will be a somewhat contradictory "sorry, I only
> support versions 2 through 4."
hmmm.... good point... But I wonder if this would be better
handled in rpc.nfsd process; Similar to what happens when
no transports are specified (i.e. both -T and -U flags are set),
the server fails to started.

steved.
