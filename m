Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWDLNJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWDLNJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWDLNJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:09:38 -0400
Received: from zux221-122-143.adsl.green.ch ([81.221.122.143]:57852 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S932190AbWDLNJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:09:37 -0400
Date: Wed, 12 Apr 2006 15:08:45 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: CRTSCTS wrong in man tcsetattr
Message-ID: <20060412130845.GA24527@kestrel.barix.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Man tcsetattr in gentoo implicitly states that after
#include <termios.h>
#include <unistd.h>

CRTSCTS constant will be defined. This is however false:
tty.c:38: error: `CRTSCTS' undeclared (first use in this function)

CRTSCTS is defined in bits/termios.h and in asm/termbits.h The question
is what is the correct state of affairs?
1) the manpage should say bits/termios.h instead of termios.h
2) the manpage should say asm/termbits.h instead of termios.h
3) the termios.h should include bits/termios.h or asm/termbits.h
4) the manpage should not mention CRTSCTS at all

CL<
