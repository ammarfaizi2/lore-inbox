Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265695AbUGGXuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUGGXuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 19:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUGGXuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 19:50:50 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:11283 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265692AbUGGXuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 19:50:11 -0400
Date: Thu, 8 Jul 2004 01:50:07 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: update document
Message-ID: <20040707235007.GA5687@pclin040.win.tue.nl>
References: <87d637mxig.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d637mxig.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 04:24:07AM +0900, OGAWA Hirofumi wrote:

>  config FAT_DEFAULT_IOCHARSET
>  	string "Default iocharset for FAT"
>  	depends on VFAT_FS
>  	default "iso8859-1"
>  	help
> -	  Set this to the default I/O character set you'd like FAT to use.
> -	  It should probably match the character set that most of your
> -	  FAT filesystems use, and can be overridded with the 'iocharset'
> -	  mount option for FAT filesystems.  Note that UTF8 is *not* a
> -	  supported charset for FAT filesystems.
> +	  Set this to the default input/output character set you'd
> +	  like FAT to use. It should probably match the character set
> +	  that most of your FAT filesystems use, and can be overrided
> +	  with the "iocharset" mount option for FAT filesystems.
> +	  Note that "utf8" is not recommended for FAT filesystems.
> +	  If unsure, you shouldn't set "utf8" to here.
> +	  See <file:Documentation/filesystems/vfat.txt> for more information.

s/overrided/overridden/
s/to here/here/


I am not in favour of introducing such configuration options.

This is just the default for a mount option. No twiddling at
kernel configuration time is required or useful.

We have too many configuration options. It is not true that the system
becomes better when there are more compile-time configuration possibilities.
Quite the contrary.

Compilation options should select inclusion of subsystems,
modules, drivers, but not twiddle behaviour.

Andries



[So, I would be happier if you selected a default and made everybody who
wants something else adapt her /etc/fstab, or alias for a mountfat command.]
