Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263594AbUDTTQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbUDTTQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 15:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUDTTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 15:16:11 -0400
Received: from florence.buici.com ([206.124.142.26]:22409 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263594AbUDTTQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:16:09 -0400
Date: Tue, 20 Apr 2004 12:16:03 -0700
From: Marc Singer <elf@buici.com>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: Support for building individual .ko's would be nice :-)
Message-ID: <20040420191603.GA25198@buici.com>
References: <20040420185904.GA27037@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420185904.GA27037@ee.oulu.fi>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 09:59:04PM +0300, Pekka Pietikainen wrote:
> I was told you're the man to bug about this :-)
> 
> Having a slow box, a vendor kernel (+ kernel-source package with config
> for it) and a need to modify one line of a module, recompile it,
> replace existing module with it and continue business as usual
> made me notice kbuild doesn't seem to have a facility for this.
> 
> What would be nice is (say)
> 
> cp configs/xxx-i686.config .config
> emacs drivers/media/dvb/frontends/ves1820.c
> make drivers/media/dvb/frontends/ves1820.ko
> cp ves1820.ko /lib/modules/...
> rmmod ves1820; modprobe ves1820 
> 
> Or am I missing something obvious that let me get just that one .ko
> without recompiling just about everything? (.o is easy, but that's
> not very useful :-) )

If you leave the compiled tree intact, all you need to do is modify
the one source file and then "make modules".  You'll wait a while the
first time, but successive builds will be minimal.

