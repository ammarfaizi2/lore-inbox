Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUFIRMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUFIRMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUFIRMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:12:14 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:1221 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S266215AbUFIRML convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:12:11 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
References: <xb7oenxyqly.fsf@savona.informatik.uni-freiburg.de>
	<200406071551.i57Fpl89023562@turing-police.cc.vt.edu>
	<xb7zn7fwdia.fsf@savona.informatik.uni-freiburg.de>
	<200406071636.i57Gafh7024942@turing-police.cc.vt.edu>
	<xb7r7sqwncc.fsf@savona.informatik.uni-freiburg.de>
	<200406081502.i58F2gF3013622@turing-police.cc.vt.edu>
	<xb765a1uovz.fsf@savona.informatik.uni-freiburg.de>
	<200406091656.i59GuDeH019833@turing-police.cc.vt.edu>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 09 Jun 2004 19:12:09 +0200
In-Reply-To: <200406091656.i59GuDeH019833@turing-police.cc.vt.edu>
Message-ID: <xb7smd4u046.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

    Valdis> On Wed, 09 Jun 2004 10:17:04 +0200, Sau Dan Lee said:
    >> Explain to me how a kernel compiled with CONFIG_SERIO=m
    >> CONFIG_KEYBOARD_ATKBD=m would be able to boot with
    >> "init=/bin/sh" and still have the keyboard working.

    Valdis> Explain to me why you think that example is a good reason
    Valdis> why a kernel compiled with

    Valdis> CONFIG_SERIO=y 
    Valdis> CONFIG_KEYBOARD_ATKBD=y

    Valdis> should *NOT* be able to boot with 'init=/bin/sh'.

"make help" shows:

    ...
    Configuration targets:
      oldconfig       - Update current config utilising a line-oriented program
      menuconfig      - Update current config utilising a menu based program
      xconfig         - Update current config utilising a QT based front-end
      gconfig         - Update current config utilising a GTK based front-end
      defconfig       - New config with default answer to all options
      allmodconfig    - New config selecting modules when possible
      allyesconfig    - New config where all options are accepted with yes
      allnoconfig     - New minimal config


A person trying to upgrade from 2.4 would suppose that the 2.4 .config
won't work and  would likely start with "make  allmodconfig", and then
"make {menu/x}config".   With 100s (or 1000s)  of configuration items,
it is not easy for a 2.4-er to discover that one now has to explicitly
enable i8042 and atkbd.  So, it is likely for him to have:

        CONFIG_SERIO=m
        CONFIG_KEYBOARD_ATKBD=m



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

