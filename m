Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161270AbWGJAEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWGJAEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWGJAET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:04:19 -0400
Received: from mail.suse.de ([195.135.220.2]:25016 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161270AbWGJAET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:04:19 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Use target filename in BUG_ON and friends
Date: Mon, 10 Jul 2006 02:03:07 +0200
User-Agent: KMail/1.9.3
Cc: Milton Miller <miltonm@bga.com>, LKML <linux-kernel@vger.kernel.org>
References: <20060708084713.GA8020@mars.ravnborg.org> <b2ab6d298877aff62aa61e0430a16d3d@bga.com> <20060708205707.GB13124@mars.ravnborg.org>
In-Reply-To: <20060708205707.GB13124@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100203.07206.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 22:57, Sam Ravnborg wrote:
> On Sat, Jul 08, 2006 at 11:45:49AM -0500, Milton Miller wrote:
> > 			
> > On Jul 8, 2006, at 04:45:54 EST, Sam Ravnborg wrote:
> > > When building the kernel using make O=.. all uses of __FILE__ becomes
> > > filenames with absolute path resulting in increased text size.
> > > Following patch supply the target filename as a commandline define
> > > KBUILD_TARGET_FILE="mmslab.o"
> > 
> > Unfortunately this ignores the fact that __LINE__ is meaningless
> > without __FILE__ because there are way too many BUGs in header
> > files.
> 
> __LINE__ gives a very precise hint of the offending .h file.
> For x86_64 there are only one line-number clash in include/ for uses of
> __FILE__.


It's a nasty encoding. Maybe you could add a script to resolve them? 

-Andi

