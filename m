Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTDGPEj (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbTDGPEj (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:04:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62868
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263512AbTDGPEi (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 11:04:38 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049727199.894.60.camel@localhost>
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
	 <20030406183234.1e8abd7f.akpm@digeo.com>
	 <1049679689.753.170.camel@localhost>  <1049680078.753.173.camel@localhost>
	 <1049715944.2967.44.camel@dhcp22.swansea.linux.org.uk>
	 <1049727199.894.60.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049725059.2967.62.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 15:17:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 15:53, Robert Love wrote:
> On Mon, 2003-04-07 at 07:45, Alan Cox wrote:
> 
> > I've forwarded the report to the RH RPM maintainer to look into. I know
> > the non NPTL cases are ok because I never run Red Hat kernels except in
> > the install process. If there are subtle NPTL differences anything is of
> > course possible
> 
> Someone reported it was an issue with O_DIRECT, which I guess is also
> possible.

Confirmed by RH people. Its a problem with how rpm misuses O_DIRECT. When
non NPTL is in use the problem doesn't occur. So its an RPM bug, problems
to redhat not Linus 8)

