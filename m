Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264223AbTCXOLX>; Mon, 24 Mar 2003 09:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264215AbTCXOLW>; Mon, 24 Mar 2003 09:11:22 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:64139 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP
	id <S264223AbTCXOK4>; Mon, 24 Mar 2003 09:10:56 -0500
Date: Mon, 24 Mar 2003 14:21:58 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: struct nfs_fattr alignment problem in nfs3proc.c
Message-ID: <20030324142158.GD17163@malvern.uk.w2k.superh.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030321175206.GA17163@malvern.uk.w2k.superh.com> <shs7karzmwv.fsf@charged.uio.no> <20030324120923.GB17163@malvern.uk.w2k.superh.com> <20030324134927.GC17163@malvern.uk.w2k.superh.com> <shsel4wsvtr.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsel4wsvtr.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 24 Mar 2003 14:22:03.0820 (UTC) FILETIME=[BDD756C0:01C2F210]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust <trond.myklebust@fys.uio.no> [2003-03-24]:
> >>>>> " " == Richard Curnow <Richard.Curnow@superh.com> writes:
> 
>      > + if (((unsigned long) arg & 0x7) != 0) {
>      > + printk("nfs3_proc_unlink_setup : arg not 8-byte aligned!\n");
>      > + }
>      > + if (((unsigned long) res & 0x7) != 0) {
>      > + printk("nfs3_proc_unlink_setup : res not 8-byte aligned!\n");
>      > + }
> 
> Nope...
> 

Well spotted, ignore those checks :-)  At least they showed that the
change higher up was making a difference.

Once there's general agreement about this fix, I'll generate some
patches for up-to-date 2.4 and 2.5.

Cheers
Richard

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
Speaking for myself, not on behalf of SuperH
