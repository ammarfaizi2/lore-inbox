Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUFAJNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUFAJNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbUFAJNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:13:47 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:65433 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264948AbUFAJNp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:13:45 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <xb73c5f8z9f.fsf@savona.informatik.uni-freiburg.de> <20040528195709.GB5175@pclin040.win.tue.nl> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
Subject: BUG FIX: atkbd.c keyboard driver bug [Was: keyboard problem with 2.6.6]
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 01 Jun 2004 11:13:43 +0200
Message-ID: <xb7n03n7i9k.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Dan> Relatedly, drivers/char/keyboard.c assumes that SysRq cannot
    Dan> be activated unless the Alt key(s) is/are pressed (and not
    Dan> yet released).  I'm going to fix this.  But since this not a
    Dan> module, I need to reboot to test it.  So, please be patient.

Fixed.  The patch is already added to Bugzilla.

Using these  patches, the  keyboard behaviour is  correct again  on my
notebook:

        SysRq ==> Input Event with code KEY_SYSRQ
        PrintScreen ==> Input Event with code KEY_KPASTERISK
                        (because PrintScreen is Alt-KP_ASTERISK)

        SysRq SPACE gives sysrq help screen
        Alt-PrintScreen SPACE gives sysrq help screen
        PrintScreen SPACE gives "*" and no sysrq help screen        

    Dan> See http://bugzilla.kernel.org/show_bug.cgi?id=2808 for more
    Dan> info.

Both patches are there at the Bugzilla site.


(BTW, why did  Vojtech REJECT this bug report at  Bugzilla?  Give me a
reason!  I do observe the bug and I have even found a fix.)


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

