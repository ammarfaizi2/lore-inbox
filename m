Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTJAFXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTJAFXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:23:12 -0400
Received: from tantale.fifi.org ([216.27.190.146]:31624 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261929AbTJAFXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:23:11 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
	<E1A4WNJ-000182-00@calista.inka.de>
	<20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
	<bldmhg$qoa$1@cesium.transmeta.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 30 Sep 2003 22:22:05 -0700
In-Reply-To: <bldmhg$qoa$1@cesium.transmeta.com>
Message-ID: <87r81x5y82.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
> By author:    viro@parcelfarce.linux.theplanet.co.uk
> In newsgroup: linux.dev.kernel
> >
> > On Wed, Oct 01, 2003 at 04:05:57AM +0200, Bernd Eckenfels wrote:
> >  
> > > > +#define MS_NODIRATIME  2048    /* Do not update directory access times */
> > > > +#define MS_BIND                4096
> > > > +#define MS_POSIXACL    (1<<16) /* VFS does not apply the umask */
> > > 
> > > can we clean that up? with shifting, without shifting, with comments and without comments? I suggest to use the linuxdoc comments mandatory for the abi files.
> > 
> > 
> > ... and make it enum, while we are at it.  It's cleaner, it survives cpp
> > and it can be handled by gdb et.al. in sane way.
> > 
> > Unless we really want to support pre-v7 compilers, there is no benefit
> > in using #define for such constants.
> 
> ... except you can use #ifdef to test for obsolete headers.

A common uber-ugly trick (seen in Solaris headers) to solve this
problem is:

  enum {
  #define FOO FOO
    FOO,
  #define BAR BAR
    BAR
  } 

Phil.
