Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbTEMAWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTEMAWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:22:00 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:33152 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262977AbTEMAV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:21:56 -0400
Date: Tue, 13 May 2003 02:34:27 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK FBDEV] String drawing optimizations.
Message-ID: <20030513003427.GA19121@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0305130049520.14641-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305130049520.14641-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:02:40AM +0100, James Simmons wrote:
> 
> Please test. The pixmap code in the framebuffer layer was designed to 
> align the font data. For some hardware it is required that each scanline 
> end on a byte boundary but for some  it was to be 32 bit aligned. So the
> solution was to take the image data and padded it to what the hardware 
> needs. At present it does this by coping on byte at a time. This is just 
> plain awful. So this patch copies data a whole scanline at a time. It is
> a big performance boost. Please test before I send it to Linus. Thank 
> you.

What about getting rid of one-char putc, implementing it in terms of
putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
with current length of {fbcon,accel}_putc{s,} I was not able to find
measurable speed difference between putc and putc through putcs variants.
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

