Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290810AbSBFVPd>; Wed, 6 Feb 2002 16:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290812AbSBFVP1>; Wed, 6 Feb 2002 16:15:27 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:27671 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290810AbSBFVPN>; Wed, 6 Feb 2002 16:15:13 -0500
Date: Wed, 6 Feb 2002 16:15:11 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206161511.D21624@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <p73ofj2lpdg.fsf@oldwotan.suse.de> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com> <a3s34p$51o$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a3s34p$51o$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Feb 06, 2002 at 12:19:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 12:19:37PM -0800, H. Peter Anvin wrote:
> Followup to:  <20020206101231.X21624@devserv.devel.redhat.com>
> By author:    Jakub Jelinek <jakub@redhat.com>
> In newsgroup: linux.dev.kernel
> > 
> > Most sane architectures reserve a thread pointer register (%g6 resp. %g7 on
> > sparc, tp on ia64, ppc will use %r2, alpha uses a fast pall call as thread
> > "register", s390 uses user access register 0 (and s390x uar 0 and 1), etc.).
> > On register starved ia32 there aren't too many spare registers, so %gs is
> > used instead.
> > 
> 
> x86-64, interestingly, retains vestigial meaning of the %fs and %gs
> registers (but no others) to use as a base pointer for this reason
> alone.

Well, on x86-64 this is purely x86-64 ABI designers decision, they could
pick one of %r8 - %r15 and use that as thread pointer instead (and were
recommended to do so).

	Jakub
