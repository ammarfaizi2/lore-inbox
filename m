Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWBEBqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWBEBqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 20:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWBEBqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 20:46:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1033 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932540AbWBEBqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 20:46:10 -0500
Date: Sun, 5 Feb 2006 02:46:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: One more unlock missing in error case
Message-ID: <20060205014609.GA5271@stusta.de>
References: <43E4E318.1030304@redhat.com> <20060204160830.1a9810a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204160830.1a9810a2.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 04:08:30PM -0800, Andrew Morton wrote:
> Ulrich Drepper <drepper@redhat.com> wrote:
> >
> > This patch is needed to in addition to the other unlocking fix which is
> >  already applied.  It should be obvious that the system will deadlock in
> >  case this isn't done.
> 
> hmm.  How's about we undo that goto tangle while we're there?
>...

The fput_unlock_fail label change looks good, but IMHO moving of retval 
settings out of the if's makes the code less readable.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

