Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSKTJIA>; Wed, 20 Nov 2002 04:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKTJIA>; Wed, 20 Nov 2002 04:08:00 -0500
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:19858 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S262201AbSKTJH7>; Wed, 20 Nov 2002 04:07:59 -0500
Message-ID: <3DDB52AE.AC88EB09@pp.inet.fi>
Date: Wed, 20 Nov 2002 11:15:26 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Can't allocate memory when loading a module 2.5.48-bk
References: <20021120084303.GB22936@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> With Linus's latest bk tree (plus some USB patches) I get the following
> error when trying to load the parport.o module:
> 
> # modprobe parport
> FATAL: Error inserting /lib/modules/2.5.48/kernel/parport.o: Cannot allocate memory
> 
> Any ideas?

Tag some init code with __init

At least stock 2.5.48 tries to happily allocate zero bytes for init section,
and gets a null pointer. That 'error' is then propagated to user space.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

