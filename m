Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVDAD0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVDAD0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVDAD0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:26:10 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:29595 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262572AbVDAD0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:26:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sDhSMfkEBf1Af/kMhILq5nhzrXBlUvvTJI4T6PhmE4HZnpS7LYyVEQ87aFjEni8efsps8RUuxPKxmXxykecdovVZBfy5rskRS7RuDPfavgX+T1R+FHnHAyqDe82C5y7MpMWSg2aji9RyT57kjV1+o4loFjWQw5uSP2NLZATp1Hc=
Message-ID: <9f506fbc05033119266e5a8eec@mail.gmail.com>
Date: Thu, 31 Mar 2005 19:26:07 -0800
From: Drew Hess <drew.hess@gmail.com>
Reply-To: Drew Hess <drew.hess@gmail.com>
To: Paul Jackson <pj@engr.sgi.com>
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, johnpol@2ka.mipt.ru,
       akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net
In-Reply-To: <20050329072335.52b06462.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	 <20050328134242.4c6f7583.pj@engr.sgi.com>
	 <1112079856.5243.24.camel@uganda>
	 <20050329004915.27cd0edf.pj@engr.sgi.com>
	 <1112087822.8426.46.camel@frecb000711.frec.bull.fr>
	 <20050329072335.52b06462.pj@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 07:23:35 -0800, Paul Jackson <pj@engr.sgi.com> wrote:

> Out of curiosity, what are these 'several user space applications?'  The
> only one I know of is this extension to bsd accounting to include
> capturing parent and child pid at fork.  Probably you've mentioned some
> other uses of fork_connector before here, but I missed it.


I have a user-space batch job scheduler that could use fork_connector
to track which processes belong to a job.  It looks perfect for what I
need.

I would also like to see a do_exit hook, but only as a convenience. I
can probably scrape the BSD accounting files in lieu of a do_exit
hook, but if I had one, I wouldn't need to touch disk for my job
accounting.

d
