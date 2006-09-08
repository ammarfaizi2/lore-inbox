Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWIHVpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWIHVpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWIHVpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:45:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:48479 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751141AbWIHVpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:45:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=gca9927MKMkRAQDju0UcJ9+EJPaSY3FpM3xswZ84uHchjxL5D2sV6tvZ9uc3LcT3P
	NUs4/Cr03DY7mh7eP9Amg==
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: sekharan@us.ibm.com
Cc: Pavel Emelianov <xemul@openvz.org>, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1157743424.19884.65.camel@linuxchandra>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>  <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 08 Sep 2006 14:43:54 -0700
Message-Id: <1157751834.1214.112.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 12:23 -0700, Chandra Seetharaman wrote:
> On Fri, 2006-09-08 at 11:33 +0400, Pavel Emelianov wrote:
> > Chandra Seetharaman wrote:
> > > On Thu, 2006-09-07 at 00:47 +0530, Balbir Singh wrote:
> > >
> > > <snip>
> > >> Some not quite so urgent ones - like support for guarantees. I think
> > >> this can
> > >
> > > IMO, guarantee support should be considered to be part of the
> > > infrastructure. Controller functionalities/implementation will be
> > > different with/without guarantee support. In other words, adding
> > > guarantee feature later will cause re-implementations.
> > I'm afraid we have different understandings of what a "guarantee" is.
> > Don't we?
> 
> may be (I am not sure :), lets get it clarified.
>  
> > Guarantee may be one of
> > 
> >   1. container will be able to touch that number of pages
> >   2. container will be able to sys_mmap() that number of pages
> >   3. container will not be killed unless it touches that number of pages
> >   4. anything else
> 
> I would say (1) with slight modification
>    "container will be able to touch _at least_ that number of pages"
> 

Does this scheme support running of tasks outside of containers on the
same platform where you have tasks running inside containers.  If so
then how will you ensure processes running out side any container will
not leave less than the total guaranteed memory to different containers.



-rohit

