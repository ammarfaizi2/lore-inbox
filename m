Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFZQxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 12:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFZQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 12:53:51 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:54230 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id S262127AbTFZQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 12:53:42 -0400
Message-ID: <3EFB2864.50304@oracle.com>
Date: Thu, 26 Jun 2003 19:07:48 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Molina <tmolina@copper.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Synaptics support kills my mouse
References: <Pine.LNX.4.44.0306251857390.921-100000@lap.molina>
In-Reply-To: <Pine.LNX.4.44.0306251857390.921-100000@lap.molina>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> I realized I forgot to include some useful information.  Following are the 
> relevant boot messages.  It appears to correctly detect my touchpad but 
> doesn't give me a mouse cursor, even in text consoles.
> 
> Jun 25 18:41:26 lap kernel: mice: PS/2 mouse device common for all mice
> Jun 25 18:41:26 lap kernel: Synaptics Touchpad, model: 1
> Jun 25 18:41:26 lap kernel:  Firware: 4.6
> Jun 25 18:41:26 lap kernel:  Sensor: 15
> Jun 25 18:41:26 lap random: Initializing random number generator: succeeded
> Jun 25 18:41:26 lap kernel:  new absolute packet format
> Jun 25 18:41:26 lap kernel:  Touchpad has extended capability bits
> Jun 25 18:41:26 lap kernel:  -> four buttons
> Jun 25 18:41:26 lap kernel:  -> multifinger detection
> Jun 25 18:41:26 lap kernel:  -> palm detection
> Jun 25 18:41:26 lap kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
> Jun 25 18:41:26 lap kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Jun 25 18:41:26 lap kernel: input: AT Set 2 keyboard on isa0060/serio0
> Jun 25 18:41:26 lap kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

Same issue on my Dell Latitude C640. No cursor in X, no cursor in
  framebuffer. gpm silently waits in select() even pointing to
  /dev/input/mice instead of /dev/psaux.

Jun 25 20:21:47 incident kernel: mice: PS/2 mouse device common for all mice
Jun 25 20:21:47 incident kernel: Synaptics Touchpad, model: 1
Jun 25 20:21:47 incident kernel:  Firware: 5.9
Jun 25 20:21:47 incident kernel:  180 degree mounted touchpad
Jun 25 20:21:47 incident kernel:  Sensor: 27
Jun 25 20:21:47 incident kernel:  new absolute packet format
Jun 25 20:21:47 incident kernel:  Touchpad has extended capability bits
Jun 25 20:21:47 incident kernel:  -> multifinger detection
Jun 25 20:21:47 incident kernel:  -> palm detection
Jun 25 20:21:47 incident kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
Jun 25 20:21:47 incident kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 25 20:21:47 incident kernel: input: AT Set 2 keyboard on isa0060/serio0
Jun 25 20:21:47 incident kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

--alessandro

  "I'm always trying to find some kind of honest emotion
    and connection with the most naked human emotions.
   It's a dangerous, dark path but also very exciting."
       (Steve Wynn, interviewed by 'Mescalina', 2003)

