Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130062AbRCAWdw>; Thu, 1 Mar 2001 17:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130064AbRCAWdn>; Thu, 1 Mar 2001 17:33:43 -0500
Received: from unthought.net ([212.97.129.24]:39656 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S130062AbRCAWda>;
	Thu, 1 Mar 2001 17:33:30 -0500
Date: Thu, 1 Mar 2001 23:33:28 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Fernando Fuganti <fuganti@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ZF MachZ Watchdog driver
Message-ID: <20010301233328.A11851@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Fernando Fuganti <fuganti@conectiva.com.br>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.21.0103011924480.991-200000@ze.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103011924480.991-200000@ze.distro.conectiva>; from fuganti@conectiva.com.br on Thu, Mar 01, 2001 at 07:37:46PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 07:37:46PM -0300, Fernando Fuganti wrote:
> 
> Hi !
> 
> This is the driver for the builtin watchdog device on the embedded MachZ
> processor made by ZFmicro. The patch is against 2.2.19pre16 and the
> driver is based on sbc60xxwdt.c. 
> 

I have a user-space daemon for driving the watchdog.  I see it uses the
same user-space interface as sbc60xxwdt.c, except it can't be disabled :)

Did you write one too ?

Should we find somewhere to actually publish these watchdog-daemons ?

Or have I completely missed that there already is a place for these
daemons, and that there already exist publicly available daemons for
driving the sbc60xxwdt and ZFmicro ?

Btw. Alan, the documentation somehow got lost to the sbc60xxwdc driver
when you so kindly converted it to 2.4  -  it's here below  :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:


diff -Nru linux/Documentation/Configure.help linux.loaded/Documentation/Configure.help
--- linux/Documentation/Configure.help	Wed Apr 26 20:03:13 2000
+++ linux.loaded/Documentation/Configure.help	Wed Apr 26 19:31:41 2000
@@ -9371,6 +9371,18 @@
   module, say M here and read Documentation/modules.txt. Most people
   will say N.
 
+SBC-60XX Watchdog Timer
+CONFIG_60XX_WDT
+ This driver can be used with the watchdog timer found on some
+ single board computers, namely the 6010 PII based computer.
+ It may well work with other cards.  It reads port 0x443 to enable
+ and re-set the watchdog timer, and reads port 0x45 to disable
+ the watchdog.  If you have a card that behave in similar ways,
+ you can probably make this driver work with your card as well.
+
+ You can compile this driver directly into the kernel, or use
+ it as a module.  The module will be called sbc60xxwdt.o.
+
 Enhanced Real Time Clock Support
 CONFIG_RTC
   If you say Y here and create a character special file /dev/rtc with
