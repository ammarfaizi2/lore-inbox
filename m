Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUHVVTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUHVVTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUHVVTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:19:13 -0400
Received: from herkules.viasys.com ([194.100.28.129]:53715 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S261724AbUHVVTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:19:09 -0400
Date: Mon, 23 Aug 2004 00:19:03 +0300
From: Ville Herva <vherva@viasys.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040822211903.GO23741@viasys.com>
Reply-To: vherva@viasys.com
References: <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org> <20040821062927.GM23741@viasys.com> <20040821134918.GA1585@devserv.devel.redhat.com> <20040821190027.GQ3024@viasys.com> <20040821190730.GA25932@devserv.devel.redhat.com> <20040822143112.GB24092@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822143112.GB24092@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 04:31:12PM +0200, you [Petr Vandrovec] wrote:
> 
> During weekend I was able to create binary patch for VMware Workstation
> 3.2.1 (patch available at
> http://platan.vc.cvut.cz/ftp/pub/vmware/vmware-any-any-update82.tar.gz)
> which turns that messy ioctl & /dev/mem mmap to simpler, safer and better
> /dev/vmmon mmap (and unmap + ioctl to simple unmap) (as used by
> WS4+/GSX3+).  After that WS 3.2.1 works on your 2.6.8.1-mm3 without
> problems (after applying two patches I'm sending you separately to get
> -mm3 to work at all on my notebook).

Incredible. 

I was sure I was out of look with the aged vmware 3.2.0, and now suddenly
there is patch for both the kernel and the application :).
 
> Ville, please try applying vmware-any-any-update82.tar.gz.  During
> application it must say that it found 'VMware Workstation 3.2.1-build
> 2242'.  If it will say that it found build-2230 to 2242, new binary
> pattern was not recognized and I'll need your vmware binary, as I did not
> find build 2230 in my archive. Or you can upgrade to the build 2242.

I didn't even realize 2242 had been released ;). (As I said, I've lately
been using vmware less and less.)

I just upgraded to 2242 + any2any82 and it works fine (*). I'm still using
the 2.6.8.1-mm2 with the updated dev-mem restriction patch. I'll retest this
as soon as I get to upgrade my kernel again to something that doesn't
contain Arjan's new dev-mem patch. I'll let you know.

*) Apart from that even 3.2.1 2242 does not fix the altgr key that does not
   seem to work with 2.6 new input system. I presume the new input layer is
   the reason; I do know altgr used to work with 2.4 host kernel and winxp
   guest.



-- v -- 

v@iki.fi


