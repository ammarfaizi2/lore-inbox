Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVE1JKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVE1JKs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 05:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVE1JKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 05:10:48 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:34488 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262528AbVE1JKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 05:10:30 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: 2.6.12-rc5-mm1 alsa oops
Date: Sat, 28 May 2005 11:10:26 +0200
User-Agent: KMail/1.7.2
Cc: "'Andrew Morton'" <akpm@osdl.org>, "Wolfgang Wander" <wwc@rentec.com>,
       rlrevell@joe-job.com, pharon@gmail.com, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
References: <200505271642.j4RGgbg03476@unix-os.sc.intel.com>
In-Reply-To: <200505271642.j4RGgbg03476@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281110.26790.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 18:42, Chen, Kenneth W wrote:
> Andrew Morton wrote on Thursday, May 26, 2005 2:25 PM
>
> > > >>this has to do with alsa indirectly. snd_pcm_mmap_data_close()
> > > >> accesses some vm_area_struct->vm_private_data and apparently there
> > > >> have been some optimizations to mmap code to avoid fragmentation of
> > > >> vma's so i think there's the problem. However, we'll need the
> > > >> smarter ones here :))
> > > >
> > > > Any idea which patches to back out?
> > >
> > > avoiding-mmap-fragmentation-fix-2.patch
> > >
> > > seems to do the trick. Ken will likely have a fix-3 shortly ;-)
> >
> > Yup.  This appears to be not-an-alsa-bug.  Thanks.
>
> I'm the guilty one here.  avoiding-mmap-fragmentation-fix-2.patch has
> a major clash using vm_private_data where alsa is also using.  I just
> posted a patch, please try that out.  Thanks.
>
> http://marc.theaimsgroup.com/?l=linux-mm&m=111721191501940&w=2
this one seems to be fine. Lightly tested for several hours yesterday.

Regards,
Boris.
