Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWJPOeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWJPOeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJPOeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:64998 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750751AbWJPOeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:34:16 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: dwarf2 stuck Re: lockdep warning in i2c_transfer() with dibx000 DVB - input tree merge plans?
Date: Mon, 16 Oct 2006 16:34:10 +0200
User-Agent: KMail/1.9.3
Cc: "Jiri Kosina" <jikos@jikos.cz>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz> <200610161617.51111.ak@suse.de> <4533B249.76E4.0078.0@novell.com>
In-Reply-To: <4533B249.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161634.10329.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 16:24, Jan Beulich wrote:
> >> Yes, unfortunately this is another instance of gcc 4.0 generating bad
> >> unwind data when optimizing and not accumulating outgoing args.
> >> Andi - did you already create a patch implementing Michael's suggestion?
> >
> >You mean using -maccumulate-outgoing-args ? Not yet.
> >
> >I guess we can do it unconditionally for all gccs on both i386
> >and x86-64, right?
> 
> Yes, I concluded this from Michael's description; what I don't know is
> whether the option isn't available on very old gcc-s.

Mainline only supports gcc 3.1+ these days, so we don't really care
about those.

I did the change. 

-Andi
