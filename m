Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314607AbSEFRi7>; Mon, 6 May 2002 13:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314610AbSEFRi6>; Mon, 6 May 2002 13:38:58 -0400
Received: from codepoet.org ([166.70.14.212]:5809 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314607AbSEFRi5>;
	Mon, 6 May 2002 13:38:57 -0400
Date: Mon, 6 May 2002 11:38:57 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: _reliable_ way to get the dev for a mount point?
Message-ID: <20020506173857.GA24013@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Pozsar Balazs <pozsy@sch.bme.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0205051830060.28842-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon May 06, 2002 at 11:55:38AM +0200, Pozsar Balazs wrote:
> So, my question is there a way to get back the device for a directory,
> _reliably_. (I want to know which devices holds the files my process sees
> under an arbitrary /path/to/somewhere).

stat(mnt_point, &statbuf); then walk through /dev and stat each
device, check that it is a block device and that st_rdev matches
the statbuf.st_rdev.  When you get a match, you know a device
name for the directory.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
