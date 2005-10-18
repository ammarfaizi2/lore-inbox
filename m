Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVJROmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVJROmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVJROmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:42:55 -0400
Received: from khc.piap.pl ([195.187.100.11]:23556 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750770AbVJROmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:42:54 -0400
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, Rudolf Polzer <debian-ne@durchnull.de>,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for
 local root compromise
References: <E1EQofT-0001WP-00@master.debian.org>
	<20051018044146.GF23462@verge.net.au>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 18 Oct 2005 16:42:49 +0200
In-Reply-To: <20051018044146.GF23462@verge.net.au> (horms@verge.net.au's
 message of "Tue, 18 Oct 2005 13:41:48 +0900")
Message-ID: <m37jcakhsm.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms <horms@verge.net.au> writes:

>> Then log out and let root login (in a computer pool, you can usually get
>> an admin to log on as root on a console somehow). The next time he'll
>> press TAB to complete a file name, he instead will run the shell
>> command.

Why doesn't the intruder just simulate login process (printing "login: "
and "Password:")? That's known and used for ages.

The root user (and any other user) should press the SAK key before
attempting login. It should a) reset terminal to a sane state,
b) terminate and/or disconnect all processes from current tty.

Alternatively, he/she should hw-reset/power-cycle the terminal,
if possible (say, with serial/X-terminal).

OTOH I don't know why ordinary users should be allowed to change key
bindings.

BTW: Not sure about Linux consoles, but in general ESCape sequences
can redefine key bindings as well. That's why SAK/reset is so important.
-- 
Krzysztof Halasa
