Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263469AbUKZV4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbUKZV4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbUKZVur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:50:47 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:14260 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263948AbUKZVrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:47:40 -0500
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125233243.GB2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101298112.5805.330.camel@desktop.cunninghams>
	 <20041125233243.GB2909@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101427035.27250.161.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 10:57:15 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 10:32, Pavel Machek wrote:
> You have your own abstraction on the top of /proc? That's no-no.

You'd prefer the same code repeated 20 times?

> ...aha, you do that to enable plugin system. Take it as another reason
> why plugins have to go.

No, it's just useful. The /proc abstraction predated the plugins. What I
really want to do is switch to kobjects for the plugins. But that can
wait a little longer.

> And your own keyboard driver :-(.

It's not really a keyboard driver. We're just making serial console and
local keypresses into the same key codes and letting them be handled by
the relevant plugin.

> > +		say("BIG FAT WARNING!! %s\n\n", suspend_print_buf);
> > +		if (can_erase_image) {
> > +			say("If you want to use the current suspend image, reboot and try\n");
> > +			say("again with the same kernel that you suspended from. If you want\n");
> > +			say("to forget that image, continue and the image will be erased.\n");
> > +		} else {
> > +			say("If you continue booting, note that any image WILL NOT BE REMOVED.\n");
> > +			say("Suspend is unable to do so because the appropriate modules aren't\n");
> > +			say("loaded. You should manually remove the image to avoid any\n");
> > +			say("possibility of corrupting your filesystem(s) later.\n");
> > +		}
> > +		say("Press SPACE to reboot or C to continue booting with this kernel\n");
> 
> Plus kernel now actually expects user interaction to solve problems
> during boot. No, no.

You want your cake and to eat it too? :> We don't want to warn the user
before they shoot themselves in the foot, but not loudly enough that
they can't help notice and choose to do something before the damage is
done?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

