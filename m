Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbUDTHVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUDTHVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUDTHVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:21:00 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:35745 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262286AbUDTHU6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:20:58 -0400
To: "E.Rodichev" <er@sai.msu.su>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux problem (2.6.5)
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 20 Apr 2004 09:20:50 +0200
Message-ID: <xb7ekqjglnx.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rodichev" == E Rodichev <er@sai.msu.su> writes:

    Rodichev> There is a good problem description at
    Rodichev> http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/
    Rodichev> and a user space driver which solves the problem. It
    Rodichev> works fine with 2.6.3, but not with 2.6.5.

    Rodichev> The reason is that in 2.6.5 it looks impossible to
    Rodichev> disable the existing mouse driver, which conflicts with
    Rodichev> driver from Tuukka Toivonen. My temporary solution was
    Rodichev> as follows:

--- drivers/input/Kconfig.orig  2004-04-04 07:36:18.000000000 +0400
+++ drivers/input/Kconfig       2004-04-20 03:45:31.000000000 +0400
@@ -26,7 +26,6 @@ comment "Userland interfaces"

 config INPUT_MOUSEDEV
        tristate "Mouse interface" if EMBEDDED
-       default y
        depends on INPUT
        ---help---
          Say Y here if you want your mouse to be accessible as char devices



Well...  that  means you can disable  that option if  you have enabled
CONFIG_EMBEDDED, which is the top level option "Remove kernel features
(for embedded  systems)".  I  don't understand why  they make  it like
that.  It's quite unintuitive.

I  have  added  this  note  to  my latest  Kconfig  for  psaux,  which
unfortunately was not released.  :P




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

