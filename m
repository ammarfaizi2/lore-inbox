Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUAJEY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 23:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUAJEY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 23:24:27 -0500
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:45265 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S264883AbUAJEYZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 23:24:25 -0500
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: Make the init-process look like the StarWars Credits
Date: Fri, 9 Jan 2004 21:07:13 -0500
User-Agent: KMail/1.5.4
References: <3FFEDD1D.7000003@ippensen.de> <200401091218.12671.rpc@cafe4111.org> <yw1xisjlvudf.fsf@kth.se>
In-Reply-To: <yw1xisjlvudf.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401092107.13588.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 13:39, Måns Rullgård wrote:
> I suppose it would be possible to use 3D features of the graphics
> chip.  It would require a rather massive hacking in the fb driver, of
> course.

massive hacking? hehe, yea. geniuses, please stop me when I stop making 
sense...

AFAICT, that would be both excellent and terrible at the same time. using hw 
accel makes the process lighter on CPU and looks great but ridiculously 
intense on the coder... i mean, who could you recruit to take X11 vid drivers 
and mutate them into kernel code? you'd need 3D code that belongs to Mesa, 
DRI code that belongs to whatever X module and the matching kernel module, 
possibly agpgart, and so on. by the time it's 3D, you aren't using the 
framebuffer code, you've taken the GUI and moved it into the kernel --- hello 
Win32. That's if you did it smart and made it modular enough to have other 
purposes, i.e. X11 overdrive... then X needs to know about it, or at least 
the DRI module involved, and then it's either they trip over one another or X 
gets cut down to just the libs and network activity. then maybe the kernel 
begins with X which starts your xterms fullscreen on vt1-6. all the time it's 
faster and loads sooner. and along with it, you get the legendary stability 
of a MS slop'erating system. to have that much for one brief piece of 
eyecandy is a little silly. and when the booting's done, is vt1 still zooming 
out into space? will I be able to see the top few lines of 'top'? 

the nice thing about fbmngplay is that it can easily be told to stop ;)
why not simply make the console a file or fifo, then "tail -f <file> | 
text_render_app -d /dev/fb0" as soon as init can fire it off?

there seems to be a mailing list at bootsplash.org, maybe we should be there 
instead.

http://lists.sourceforge.net/lists/listinfo/bootsplash-discussion


-- 
Rob Couto
rpc@cafe4111.org
Rules for computing success:
1) Attitude is no substitute for competence.
2) Ease of use is no substitute for power.
3) Safety matters; use a static-free hammer.
--
