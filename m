Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbUDSKSC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 06:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUDSKSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 06:18:01 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:1766 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264349AbUDSKQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 06:16:49 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Tuukka Toivonen <tuukkat@ee.oulu.fi>, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
	<20040419015221.07a214b8.akpm@osdl.org>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 19 Apr 2004 12:16:47 +0200
In-Reply-To: <20040419015221.07a214b8.akpm@osdl.org>
Message-ID: <xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

    >> The driver was originally written by Lee Sau Dan
    >> http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/ but I
    >> fixed some bugs (most importantly SMP).
    >> 
    >> I've seen lots of discussions about different mouse behaviour
    >> (or completely non-functioning mouse). If you have one of those
    >> problems, this driver should restore the kernel 2.4.x
    >> behaviour.
    >> 
    >> Any suggestions/hopes to get it included into mainstream
    >> kernel?

    Andrew> I'd imagine that the input developers would regard that as
    Andrew> a step in the wrong direction.

I know what you mean.  But please see

  http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/

for my  arguments against the  direction currently taken by  the input
developers.


Moreover, while  most people report problems of  various severity with
the mouse  after upgrading  to 2.6, the  direct psaux port  does solve
most of those problems,  providing a smooth migration path.  Actually,
I would still be staying with 2.4.* if I didn't write my psaux module,
because the touchscreen function on my notebook is important to me.  I
have written my XFree86 driver for it, and I'm not going to port it to
kernel space.

While most  Linux people frown upon  Microsoft for putting  the GUI in
the  NT kernel,  I  frown upon  the  input developers  for moving  the
functions of 'gpm' into kernel space.  I can't see any good reasons to
deprecate 'gpm' that way.


    Andrew> Have you sent a report regarding the touchscreen problem?

No.   That's not  a  problem  specific with  my  touchscreen.  It's  a
general  problem  with   the  design  of  the  input   layer.   It  is
implementing  *policies*  (on how  to  interpret  data  read from  the
PS2/AUX port), instead of providing  a *mechanism* to access (read and
write) that port.



    Andrew> Is it a straightforward bug, or has real functionality
    Andrew> been lost?

Yes.  Directly talking  to a device on the PS2/AUX  port (like what we
can do to a  RS232 port) is no longer possible in  2.6, until my psaux
module.  This is certainly a lost functionality.

See my page with URL given above for a more detailed discussion.


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

