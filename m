Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWH2QFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWH2QFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWH2QFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:05:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751076AbWH2QFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:05:43 -0400
Subject: Re: The 3G (or nG) Kernel Memory Space Offset
From: Arjan van de Ven <arjan@infradead.org>
To: Dong Feng <middle.fengdong@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
References: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
	 <Pine.LNX.4.61.0608291634380.16371@yvahk01.tjqt.qr>
	 <a2ebde260608290901w73575e18hffd8a9d6c989f523@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 29 Aug 2006 18:05:03 +0200
Message-Id: <1156867503.2722.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 00:01 +0800, Dong Feng wrote:
> 2006/8/29, Jan Engelhardt <jengelh@linux01.gwdg.de>:
> >
> > "0-4G physical memory space" denotes RAM. Since kernelspace is resident, it
> > only seems logical to map it to 0G (that is, the start of RAM), because the
> > end of RAM can be flexible.
> >
> > IOW, you cannot map kernelspace to the physical location 0xc0000000 because
> > there might not be that much RAM.
> >
> > (Also note the PCI memory hole which is near the end of the 4G range.)
> >
> >
> > Jan Engelhardt
> > --
> >
> 
> 
> Sorry for my typo. I actually means "0-1G physical memory space." My
> question is actually why there is a 3G offset from linear kernel to
> physical kernel. Why not simply have kernel memory linear space
> located on 0-1G linear address, and therefore the physical kernel and
> linear kernel just coincide?


the price for that would be that you would have to flush all the tlb's
on each syscall. That's seen as a quite hefty price by many kernel
developers.


