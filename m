Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264807AbSJVSDd>; Tue, 22 Oct 2002 14:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264800AbSJVSDB>; Tue, 22 Oct 2002 14:03:01 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49082 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264807AbSJVSBh>; Tue, 22 Oct 2002 14:01:37 -0400
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <20021022134501.C20957@redhat.com>
References: <2629464880.1035240956@[10.10.2.3]>
	<Pine.LNX.4.44L.0210221405260.1648-100000@duckman.distro.conectiva>
	<20021022131930.A20957@redhat.com> <396790000.1035308200@flay> 
	<20021022134501.C20957@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 19:22:14 +0100
Message-Id: <1035310934.31917.124.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 18:45, Benjamin LaHaise wrote:
> On Tue, Oct 22, 2002 at 10:36:40AM -0700, Martin J. Bligh wrote:
> > Bear in mind that large pages are neither swap backed or file backed
> > (vetoed by Linus), for starters. There are other large app problem scenarios 
> > apart from Oracle ;-)
> 
> I think the fact that large page support doesn't support mmap for users 
> that need it is utterly appauling; there are numerous places where it is 
> needed.  The requirement for root-only access makes it useless for most 
> people, especially in HPC environments where it is most needed as such 
> machines are usually shared and accounts are non-priveledged.

I was very suprised the large page crap went in, in the form it
currently exists. Merging pages makes sense, spotting and doing 4Mb page
allocations kernel side makes sense. The rest is very questionable

