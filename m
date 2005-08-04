Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVHDBP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVHDBP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVHDBP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:15:27 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:64578 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261665AbVHDBPY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:15:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tmw41Twfo09lhQZ/yZuHpx3SF4Kz3hJsgGYBSXd8w8LHAR9KBtFtKi6haGJd19xPbavGh8AzVpAs/2pseTDLPuCFK9Jb0GORwtAr5ZrqAuJXeDaGy3X8ZKAjiyVkA7sjBPwaVg1qZ6Sf76tUIlUICmOMKC1U7ZD83NKifAXVCA4=
Message-ID: <1c1c8636050803181547f970d9@mail.gmail.com>
Date: Thu, 4 Aug 2005 13:15:21 +1200
From: Ryan Brown <some.nzguy@gmail.com>
Reply-To: Ryan Brown <some.nzguy@gmail.com>
To: Frank Loeffler <knarf.loeffler@freenet.de>
Subject: Re: [linux-usb-devel] Re: Fw: ati-remote strangeness from 2.6.12 onwards
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <42F0AD60.3070201@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730173253.693484a2.akpm@osdl.org>
	 <1c1c8636050801220442d8351c@mail.gmail.com>
	 <20050803055413.GB1399@elf.ucw.cz>
	 <1c1c86360508030311486fc30a@mail.gmail.com>
	 <42F0AD60.3070201@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mdew wrote:
> > mapped to "p". I found the TV Button, The DVD Button, the CH-/+ and
> > the OK Button all non-working, every other button produced the "p".
> 
> Could you please try 'showkey -s' from a console on all of those keys?

Without my patch, nothing shows up when pressing OK, TV and DVD, in showkey -s

# with my patch
mediabawx2:~# showkey -s
kb mode was XLATE

press any key (program terminates after 10s of last keypress)...
0x1c 0x9c    - OK
0xe0 0x1f 0xe0 0x9f   - TV
0xe0 0x17 0xe0 0x97   - DVD

> Pavel: I would think that 'more useful' is not really the same as
> 'correct'. If you find it useful to map this key to 'ENTER', so you
> should remap it in userspace. It should not be KEY_ENTER in the kernel
> for at least two reasons:
> 
> - The key is labled 'ok' (and not enter). I assume the code KEY_OK is
>    made for exactly that kind of key and certain applications might
>    look for exactly this code.
> - You might want to differentiate between this key and the ENTER key
>    of your keyboard, at least I do. If the kernel is sending the same
>    code for both keys, this is not possible in userspace.
> 
> Frank
> 
>
