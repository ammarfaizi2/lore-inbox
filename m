Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUDUOON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUDUOON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUDUOON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:14:13 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:31189 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262634AbUDUOOH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:14:07 -0400
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, arjanv@redhat.com,
       Andrew Morton <akpm@osdl.org>, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
	<20040419015221.07a214b8.akpm@osdl.org>
	<xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
	<1082372020.4691.9.camel@laptop.fenrus.com>
	<16518.20890.380763.581386@cse.unsw.edu.au>
	<xb71xmhfu9j.fsf@savona.informatik.uni-freiburg.de>
	<Pine.GSO.4.58.0404211442170.26430@stekt37>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 Apr 2004 16:14:06 +0200
In-Reply-To: <Pine.GSO.4.58.0404211442170.26430@stekt37>
Message-ID: <xb7smexe7v5.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tuukka" == Tuukka Toivonen <tuukkat@ee.oulu.fi> writes:

    Tuukka> We shouldn't want _the_ /dev/psaux, but something similar,
    Tuukka> possibly better. What I'm after (and probably Sau Dan Lee
    Tuukka> too) is direct access to at least psaux-port.

Right!


    Tuukka> My idea is to modify serio to expose all (or at least all
    Tuukka> unconnected) ports into userspace, where programs can
    Tuukka> write/read them just like the /dev/psaux before. Then it's
    Tuukka> just matter of symlinking /dev/psaux into correct device.

Good suggestion.


Actually, I  have a  side issue with  input/i8042 related  things: The
keyboard on  my laptop worked  slightly different: On 2.4.*,  SysRq is
activated using a [Fn] key-combo,  which agrees with the keycap labels
on the  laptop keyboard.   After upgrading to  2.6, that  key-combo no
longer  works.  Instead,  I must  use Alt-PrintScreen  as the  key for
SysRq.  (And unfortunately, PrintScreen is a [Fn] combo on the laptop,
thus requiring press  3 keys at the same time for  SysRq, and a fourth
key to use  the various SysRq features.  Very  inconvenient.)  Is this
again due to some dirty translation processes down in the input layer?
Is  the input  layer always  assuming that  Alt-PrintScreen  == SysRq?
This is not always true.  Can the input layer be so configured that it
never tries  to interpret  the scancodes, but  pass them to  the upper
layers?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

