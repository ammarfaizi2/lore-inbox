Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTDGMMq (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTDGMMp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:12:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37779
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263397AbTDGMLr (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:11:47 -0400
Subject: Re: [PATCH] Qemu support for PPC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Fabrice Bellard <fabrice.bellard@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <16017.5444.941131.275543@argo.ozlabs.ibm.com>
References: <20030407024858.C32422C014@lists.samba.org>
	 <20030407065813.A27933@infradead.org>
	 <16017.2065.635724.992168@argo.ozlabs.ibm.com>
	 <20030407072144.A28096@infradead.org>
	 <16017.5444.941131.275543@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049714668.2965.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 12:24:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 07:05, Paul Mackerras wrote:
> Well, all we really want is a way to set emul_prefix.  Which I could
> do with a PPC-specific syscall if I had to, I guess.  Doing it in
> userspace is possible but ugly, because you have to handle several
> different syscalls, plus keep track of the current directory, plus
> handle symlinks, etc., etc., in the emulator.  The kernel has all that
> information readily to hand plus the data structures to keep track of
> it all.

Why do you need emul_prefix in the first place ? You need a different
/lib for emulated binaries then use all the nice stuff Al has done
and mount yourself a file system that is in your namespace but not
the global one.

If you want to do overlaying then lets get the union fs for read only
stuff into the kernel properly and solve the -real- problem not hack
up some emulator magic again.


