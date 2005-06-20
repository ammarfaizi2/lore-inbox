Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVFUINH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVFUINH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVFUIK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:10:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18067 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261648AbVFTVpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:45:45 -0400
Date: Mon, 20 Jun 2005 23:45:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050620214521.GB2222@elf.ucw.cz>
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz> <20050620204533.GA9520@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620204533.GA9520@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Apple connects their accelerometer over i2c, see:

http://www.kernelthread.com/software/ams/

For some reverse engineering attempts, see:

http://www.paul.sladen.org/thinkpad-r31/accelerometer.html

According to IBM, it is *not* enabled during system bootup:

http://www-307.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-53167

According to another text, BIOS know how to test accelerometer in some
kind of self test. Aha, here's the most interesting text:

http://www-307.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-53432

According to this text:

typical free-fall takes 300msec, but head unloading takes
300-500msec. [So I had my computation right ;-)] ... "therefore, it is
too late to start head unloading after detecting free fall"...

They really try to detect conditions just before free fall... and it
does not sound that difficult.

Another clever trick is that if user is still using the mouse, machine
is probably not in free fall ;-). In pdf, they also mention few
.sys files. They should probably be disassembled to learn how the
interface works (hint hint), actually exported symbol names should be
quite helpfull in determining what function is the interesting one. 

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
