Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbUJ3W1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUJ3W1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUJ3W1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:27:35 -0400
Received: from [66.35.79.110] ([66.35.79.110]:62619 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261266AbUJ3W13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:27:29 -0400
Date: Sat, 30 Oct 2004 15:27:20 -0700
From: Tim Hockin <thockin@hockin.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Message-ID: <20041030222720.GA22753@hockin.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 01:11:07AM +0300, Denis Vlasenko wrote:
> I am not a code genius, but want to help.
> 
> Hmm probably some bloat-detection tools would be helpful,
> like "show me source_lines/object_size ratios of fonctions in
> this ELF object file". Those with low ratio are suspects of
> excessive inlining etc.

The problem with apps of this sort is the multiple layers of abstraction.

Xlib, GLib, GTK, GNOME, Pango, XML, etc.

No one wants to duplicate effort (rightly so).  Each of these libs tries
to do EVERY POSSIBLE thing.  They all end up bloated.  Then you have to
link them all in.  You end up bloated.  Then it is very easy to rely on
those libs for EVERYTHING, rather thank actually thinking.

So you end up with the mindset of, for example, "if it's text it's XML".
You have to parse everything as XML, when simple parsers would be tons
faster and simpler and smaller.

Bloat is cause by feature creep at every layer, not just the app.

Youck.
