Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269755AbTGOVVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269758AbTGOVVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:21:40 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:12964 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269755AbTGOVUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:20:20 -0400
Date: Tue, 15 Jul 2003 22:35:05 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2.6.0-test1 - no keyboard/mouse
Message-ID: <20030715213503.GA29897@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Folkert van Heusden <folkert@vanheusden.com>,
	linux-kernel@vger.kernel.org
References: <200307152246.57389.folkert@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307152246.57389.folkert@vanheusden.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:46:57PM +0200, Folkert van Heusden wrote:
 > Ehrm, hello? Has this list became silent suddenly?
 > Anyway: I just tried 2.6.0-test1 on my celeron. Boots up flawlessly. Rather 
 > quick and all. X boots up, all fine.
 > Only one minor problem: the keyboard and the mouse do not work.
 > I *have* included input-core, etc.:
 > CONFIG_INPUT=y
 > CONFIG_INPUT_MOUSEDEV=y
 > CONFIG_INPUT_MOUSEDEV_PSAUX=y
 > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 > CONFIG_INPUT_EVDEV=y
 > CONFIG_INPUT_KEYBOARD=y
 > CONFIG_INPUT_MOUSE=y
 > CONFIG_INPUT_MISC=y
 > CONFIG_INPUT_PCSPKR=y
 > CONFIG_INPUT_UINPUT=y

Here's your problem.. (or one of them at least)..

# CONFIG_SERIO is not set

You're likely also missing a CONFIG_KEYBOARD_ATKBD=y
but that will probably appear when CONFIG_SERIO=y
along with PS2 mouse.

		Dave

