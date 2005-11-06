Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVKFCLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVKFCLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 21:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVKFCLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 21:11:37 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:57786 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751006AbVKFCLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 21:11:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pHyb6zlbg/6IYJOx+Kgaujjd/yvEwc7zCVHNyxMJZ+MBEihEKvSHKZMCGvqk2nyByA0Chqr73iCMvPVYoWrM7dMNAqhwHwzKAnys/J4nWCpK5BoU+gJfiNI6NLjPBL0cD/wmRjt7aH/XIHsiTLnOC9MToPp2L74sQnGrxVbeQ5A=
Message-ID: <436D664E.9030109@gmail.com>
Date: Sun, 06 Nov 2005 10:11:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       mlang@debian.org
Subject: Re: [PATCH] Set the vga cursor even when hidden
References: <20051105211949.GM7383@bouh.residence.ens-lyon.fr> <436D5047.4080006@gmail.com> <20051106004451.GF8183@bouh.residence.ens-lyon.fr>
In-Reply-To: <20051106004451.GF8183@bouh.residence.ens-lyon.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Hi,
> 
> Antonino A. Daplas, le Sun 06 Nov 2005 08:37:27 +0800, a écrit :
>> Why not use this method (scanline_end < scanline_start) for VGA, and
>> the default method (moving the cursor out of the screen) for the rest?
> 
> Well, visually impaired people might want to use other cards as well.

See Linus's comments about that :-)

> 
>> Or why not just set bit 5 of the cursor start register (port 0x0a) to disable
>> the cursor, and clear to enable? I believe this will also work for the
>> other types.
> 
> If this works, it would be fine.

No, forget about that.  It sounds simple, but when the cursor is moved, the
cursor is unavoidably reenabled again (in vgacon_set_cursor_size). So this method
will require more work for what's it worth. Your patch is much simpler and uses
known working code. 

Tony


