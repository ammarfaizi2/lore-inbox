Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132999AbRDKVMk>; Wed, 11 Apr 2001 17:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133001AbRDKVMU>; Wed, 11 Apr 2001 17:12:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62475 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132999AbRDKVMS>;
	Wed, 11 Apr 2001 17:12:18 -0400
Date: Wed, 11 Apr 2001 22:12:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Steven Walter <srwalter@yahoo.com>, tytso@mit.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] serial ioctl not returning with 2.4.3
Message-ID: <20010411221210.A21822@flint.arm.linux.org.uk>
In-Reply-To: <20010411142538.A27290@hapablap.dyn.dhs.org> <3AD4C38D.2C970A60@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD4C38D.2C970A60@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Apr 11, 2001 at 04:50:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 04:50:21PM -0400, Jeff Garzik wrote:
> I am not sure this is a serial driver bug:

Some ioctls are reused ;(

#define TCSETSW         0x5403

Its really a TCSETSW ioctl.

> [jgarzik@rum linux_2_4]$ find . -name '*.[ch]'|xargs grep -wn
> SNDCTL_TMR_STOP
> ./arch/sparc64/kernel/ioctl32.c:3503:COMPATIBLE_IOCTL(SNDCTL_TMR_STOP)
> ./drivers/sound/mpu401.c:1522:          case SNDCTL_TMR_STOP:
> ./drivers/sound/sequencer.c:1352:               case SNDCTL_TMR_STOP:
> ./drivers/sound/sound_timer.c:195:              case SNDCTL_TMR_STOP:
> ./drivers/sound/sys_timer.c:206:        case SNDCTL_TMR_STOP:
> ./include/linux/soundcard.h:165:#define SNDCTL_TMR_STOP                
> _SIO  ('T', 3)
> 
> -- 
> Jeff Garzik       | Sam: "Mind if I drive?"
> Building 1024     | Max: "Not if you don't mind me clawing at the dash
> MandrakeSoft      |       and shrieking like a cheerleader."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

