Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946099AbWJSPjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946099AbWJSPjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946122AbWJSPjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:39:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:14555 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946099AbWJSPjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:39:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oFNfKNRSRr1jr7UmGFyvfCEz5sNGw2O29v1fVgAiDzH3AjMGVjxXG5zmLE28IcbwolzTjRLf/jzHepMmAhyA93UM4zky/ZjVFahzgh6YhodSK2MKl/uzlHa5sE/HVdzVpfVHlU9upPAjmEfrPp3MtMzDYaVNH8nTVCZ+l6eKRQI=
Message-ID: <aa4c40ff0610190839l64c56966w39b0d8df920215f@mail.gmail.com>
Date: Thu, 19 Oct 2006 08:39:46 -0700
From: "James Lamanna" <jlamanna@gmail.com>
To: "Joerg Schilling" <Joerg.Schilling@fokus.fraunhofer.de>
Subject: Re: [PATCH] Support ISO-9660 RockRidge v. 1.12 V2
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       ismail@pardus.org.tr
In-Reply-To: <453749e8.ANSGHhMt8ZPpaILR%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45365825.05759a90.7d7c.ffffe441@mx.google.com>
	 <453749e8.ANSGHhMt8ZPpaILR%Joerg.Schilling@fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/06, Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de> wrote:
> James Lamanna <jlamanna@gmail.com> wrote:
>
> >
> > Joerg Schilling pointed out that RockRidge v. 1.12 extends the PX entry.
> > This patch stores the inode number that is now included.
> > He has also mentioned 'implementing support for new inode features' wrt to a
> > mkisofs fingerprint. Perhaps that will come at a later date.
> > Regardless, that can be built on this patch since now the inode number gets
> > stored.
> >
> > This patch has been tested against mounting an ISO-9660 image in
> > loopback that supports RockRidge v. 1.12 (thank you to Joerg for a beta
> > of mkisofs that does this).
> > This should apply against the latest git.
>
> Let me add some more notes:
>
> The linux NFS server interface is unnecessarily complex and will make it
> a lot harder than a "single line change" to make the filesystem correct in case
> Linux likes to benefit from the inode numbers in RRip 1.12 to support correct
> hardlinks.
>
> If you believe that you understand the NFS server issues, you should fix the
> code so that NFS exports will work correctly after the change. If you don't know
> what's going on there, you may need to spend a few days with testing and
> debugging.
>
> Note that you need to be able to "re-open" any file from a NFS file handle only...
> There are many constraints that need to be redeemed and the new algorithm needs
> to work correctly with old and with new media.

Hopefully I will have some time to test this box as a NFS server soon.
Unfortunately, hacking on Linux is not exactly my full-time job at the
moment.
Anyways, the patch should probably be put on hold until these
potential issues are addressed. Everything should still function fine
without any RR 1.12 patch.

-- James
