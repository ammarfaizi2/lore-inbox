Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSJVULM>; Tue, 22 Oct 2002 16:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSJVULL>; Tue, 22 Oct 2002 16:11:11 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64954 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264852AbSJVUK3>; Tue, 22 Oct 2002 16:10:29 -0400
Subject: Re: 2.4.20-pre11 /proc/partitions read
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jan Kasprzak <kas@informatics.muni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021022195807.GA26620@win.tue.nl>
References: <20021022185958.GB26585@win.tue.nl>
	<Pine.LNX.4.44L.0210221625440.27942-100000@freak.distro.conectiva>
	<20021022193226.GC26585@win.tue.nl> <20021022203504.A7770@infradead.org> 
	<20021022195807.GA26620@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 21:32:08 +0100
Message-Id: <1035318728.31873.145.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 20:58, Andries Brouwer wrote:
> The default 1K buffer was not large enough. Some utilities have now
> been patched to tell stdio to use a 16K buffer. We won't have to wait
> long before also that will turn out to be insufficient.
> 
> It is bad that one has to patch mount and the ext2 utilities and fdisk
> and I don't know what other programs because some irrelevant (to mount etc.)
> and changing stuff was added to /proc/partitions.

There are two items to dela with

#1 A bug - which Christoph fixed
#2 A question about field lengths varying - which is true if the fstab
is updated for other reasons but more likely now. Fixable by using fixed
width fields

