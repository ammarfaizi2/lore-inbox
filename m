Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbTFCO42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTFCO42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:56:28 -0400
Received: from imsantv21.netvigator.com ([210.87.250.77]:62604 "EHLO
	imsantv21.netvigator.com") by vger.kernel.org with ESMTP
	id S265037AbTFCO40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:56:26 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andrew Ryan <genanr@emsphone.com>
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Date: Tue, 3 Jun 2003 23:09:20 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306031912.53569.mflt1@micrologica.com.hk> <20030603144257.GA31734@thumper2.emsphone.com>
In-Reply-To: <20030603144257.GA31734@thumper2.emsphone.com>
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306032309.21056.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 22:42, Andrew Ryan wrote:
> On Tue, Jun 03, 2003 at 07:12:51PM +0800, Michael Frank wrote:
> > Speaking of weird errors:
> >
> > For the last few months I encounter this:
> >
> > When doing rsync or cp _from_ system running 2.4 _to_ system running 2.5
> > get Input/output error errors with random files.
> >
> > - Encountered since 2.4.20 with about 2.5.64 (my first 2.5 kernel)
>
> I am having a similar problem writing to NFS mounted non-linux system on
> kernels past 2.4.20-pre3.  I get an input/output error while writing.  I
> have sent email to Trond Myklebust (who made the changes between pre3 and
> pre4).  And he said to switch to using the TCP protocol for mounts.  That
> worked, but I should not have to do that because
>
> 1. It worked to 2.4.20pre3 without a problem
> 2. Other OSes such as FreeBSD do not have issues writing to other OSes
> using UDP soft mounts.
>
> To me, there is something wrong with the changes that went in in
> 2.4.20pre4, it should work as it does in pre3 and/or other unix OSes such
> as FreeBSD. We should not have to work around the problem with hard links
> or using TCP instead of UDP.
>

Error frequency does not change between copying from a 2400MHz@2.4 > 600Mhz@2.5 
and 600Mhz@2.4 > 2400MHz@2.5. IIRC, I had errors from a 200MHz@2.4 to a 1600Mhz@2.5 
too.

Even if I run them both against each other, the error only happens on 2.4 and
the frequency does not increase. This is not a simple timout problem.

I'll think it through and build some scripts so everone can reproduce it 
and test it out.


Regards
Michael


