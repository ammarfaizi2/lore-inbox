Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFTXFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFTXFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVFTXDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:03:07 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:981
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261222AbVFTWyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:54:10 -0400
Message-ID: <42B73B0B.1020406@linuxwireless.org>
Date: Mon, 20 Jun 2005 16:54:19 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
References: <20050620155720.GA22535@ucw.cz> <005401c575b3_5f5bba90_600cc60a@amer.sykes.com> <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz> <20050620204533.GA9520@ucw.cz> <20050620214521.GB2222@elf.ucw.cz>
In-Reply-To: <20050620214521.GB2222@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>Apple connects their accelerometer over i2c, see:
>
>http://www.kernelthread.com/software/ams/
>
>For some reverse engineering attempts, see:
>
>http://www.paul.sladen.org/thinkpad-r31/accelerometer.html
>
>According to IBM, it is *not* enabled during system bootup:
>
>http://www-307.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-53167
>
>According to another text, BIOS know how to test accelerometer in some
>kind of self test. Aha, here's the most interesting text:
>
>http://www-307.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-53432
>
>According to this text:
>
>typical free-fall takes 300msec, but head unloading takes
>300-500msec. [So I had my computation right ;-)] ... "therefore, it is
>too late to start head unloading after detecting free fall"...
>
>They really try to detect conditions just before free fall... and it
>does not sound that difficult.
>
>Another clever trick is that if user is still using the mouse, machine
>is probably not in free fall ;-). In pdf, they also mention few
>.sys files. They should probably be disassembled to learn how the
>interface works (hint hint), actually exported symbol names should be
>quite helpfull in determining what function is the interesting one. 
>
>								Pavel
>  
>
Pavel,

    Thanks for all this information and to everyone providing data. This 
is really want we want. But We need to know how to talk to the chip 
before getting any on these math results to work.

Try what Lenz said: watch -n1 cat /proc/acpi/ibm/ecdump

.Alejandro
