Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWARNYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWARNYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWARNYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:24:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19692 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932527AbWARNYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:24:07 -0500
Date: Wed, 18 Jan 2006 14:22:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Jean Delvare <khali@linux-fr.org>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
In-Reply-To: <20060118091543.GA8277@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
 <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org>
 <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The shell script check-dialog.sh is called which again do:
>echo "main() {}" | gcc -xc - -o /dev/null

Ouch, I suggested using /dev/null instead of post-removing a.out ^_^
Anyway, SUSE 10.0/i386:

14:20 takeshi:~ > l /dev/null
crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null
14:20 takeshi:~ > echo 'main(){}' | gcc -xc -c - -o /dev/null
14:21 takeshi:~ > echo $?
0
14:21 takeshi:~ > l /dev/null
crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null


14:22 takeshi:/home/jengelh # echo 'main(){}' | gcc -xc -c - -o /dev/null
14:22 takeshi:/home/jengelh # echo $?
0
14:22 takeshi:/home/jengelh # l /dev/null
crw-rw-rw-  1 root root 1, 3 Sep  9 18:40 /dev/null


So what is (not) happening?

>And it seems that gcc will trash /dev/null in your setup when doing
>this.
>One fix would be to avoid the two lines during distclean,
>but I may have to resort to a temporary file.
>
>Could you please confirm that the above command is the one that trashes
>/dev/null, then I will try to cook up something better.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
