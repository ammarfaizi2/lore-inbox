Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbTCLU47>; Wed, 12 Mar 2003 15:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262024AbTCLUzZ>; Wed, 12 Mar 2003 15:55:25 -0500
Received: from users.linvision.com ([62.58.92.114]:58307 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262013AbTCLUyr>; Wed, 12 Mar 2003 15:54:47 -0500
Date: Wed, 12 Mar 2003 22:05:16 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl,
       torvalds@transmeta.com
Subject: Re: Memleak in driver for the Specialix SX series cards.
Message-ID: <20030312220516.A20780@bitwizard.nl>
References: <20030312204114.GA28438@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312204114.GA28438@linuxhacker.ru>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 11:41:14PM +0300, Oleg Drokin wrote:
> Hello!
> 
>     I see there is a memleak in driver for the Specialix SX series cards
>     on error exit path in sx_fw_ioctl() (both in 2.4 and 2.5).
>     See the patch.
>     Found with help of smatch + unfree script.

...
> +					kfree (tmp);
>  					return -EFAULT;

Hi Oleg, 

You're right. I left it like this because "root can always mess up the
machine". But once fixed, I agree that it's better this way. 

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
