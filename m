Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTDSWiz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbTDSWiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 18:38:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56272
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263481AbTDSWiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 18:38:54 -0400
Subject: Re: firmware separation filesystem (fwfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ranty@debian.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030419204138.GC638@ranty.ddts.net>
References: <20030416163641.GA2183@ranty.ddts.net>
	 <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk>
	 <20030417012321.GB9219@zax>
	 <1050585122.31390.25.camel@dhcp22.swansea.linux.org.uk>
	 <20030419204138.GC638@ranty.ddts.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050789163.3955.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 22:52:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 21:41, Manuel Estrada Sainz wrote:
> > fwfs is a broken idea because it leaves the data in kernel space. On
> > a giant IBM monster maybe nobody cares about a few hundred K of cached
> > firmware in the kernel, but the rest of us happen to run real world
> > computers.
> 
>  Many drivers currently include this same data in kernel space, in in
>  headers, what I am trying to do is make it easy for them to support
>  fwfs (or whatever it becomes in the end). 

So what is the value in changing them to this, then changing them again
to put the firmware in userspace ? Surely you'd be better off writing
a generally usable request_firmware() hotplug interface ?

