Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUCaVqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCaVoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:44:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:22985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262611AbUCaVn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:43:59 -0500
Date: Wed, 31 Mar 2004 13:40:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Peter Williams <peterw@aurema.com>
Cc: albert@users.sourceforge.net, arjanv@redhat.com, ak@muc.de,
       Richard.Curnow@superh.com, aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
Message-Id: <20040331134009.76ca3b6d.rddunlap@osdl.org>
In-Reply-To: <405CDA9C.6090109@aurema.com>
References: <1079453698.2255.661.camel@cube>
	<20040320095627.GC2803@devserv.devel.redhat.com>
	<1079794457.2255.745.camel@cube>
	<405CDA9C.6090109@aurema.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004 10:58:20 +1100 Peter Williams wrote:

| Albert Cahalan wrote:
| > On Sat, 2004-03-20 at 04:56, Arjan van de Ven wrote:
| > 
| >>On Tue, Mar 16, 2004 at 11:14:59AM -0500, Albert Cahalan wrote:
| >>
| >>>>there is one. Nothing uses it
| >>>>(sysconf() provides this info)
| >>>
| >>>If you have a recent glibc on a recent kernel, it might.
| >>>You could also get a -1 or a supposed ABI value that
| >>>has nothing to do with the kernel currently running.
| >>>The most reliable way is to first look around on the
| >>>stack in search of ELF notes, and then fall back to
| >>>some horribly gross hacks as needed.
| >>
| >>eh sysconf() is the nice way to get to the ELF notes
| >>instead of having to grovel yourself.
| > 
| > 
| > Unless there is some hidden feature that lets
| > me specify the ELF note number directly, no way.
| > 
| > The sysconf(_SC_CLK_TCK) call does not return an
| > error code when used on a 2.2.xx i386 kernel.
| > You get an arbitrary value that fails for ARM,
| > Alpha, and any system with modified HZ.
| 
| As Linux is supposed to be POSIX compliant this is a bug and should be 
| fixed.


My understanding (from a few years back) is that Linux is POSIX
if/when/where it makes sense, but not necessarily POSIX-just-to-be-POSIX.

--
~Randy
"You can't do anything without having to do something else first."
-- Belefant's Law
