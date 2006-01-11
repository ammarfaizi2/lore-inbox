Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWAKSMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWAKSMA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAKSL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:11:56 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23943 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932420AbWAKSLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:11:55 -0500
Date: Wed, 11 Jan 2006 19:11:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] kconfig: factor out ncurses check in a shell script
In-Reply-To: <20060111165513.GA18184@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0601111910400.8019@yvahk01.tjqt.qr>
References: <11368426843316@foobar.com> <Pine.LNX.4.61.0601102127230.16049@yvahk01.tjqt.qr>
 <20060111165513.GA18184@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>+	echo "main() {}" | $compiler -lncursesw -xc - 2> /dev/null
>+	if [ $? -eq 0 ]; then
>+		echo '-lncursesw'
>+		exit
>+	fi
>+	echo "main() {}" | $compiler -lncurses -xc - 2> /dev/null
>+	if [ $? -eq 0 ]; then
> 		echo '-lncurses'
>+		exit
>+	fi
>+	echo "main() {}" | $compiler -lcurses -xc - 2> /dev/null
>+	if [ $? -eq 0 ]; then
>+		echo '-lcurses'
>+		exit
> 	fi
>+	exit 1


You forget to remove a.out, or whatever the compiler produces. I suggest
  $compiler -o /dev/null




Jan Engelhardt
-- 
