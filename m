Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWFBBnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWFBBnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWFBBnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:43:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:47680 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751089AbWFBBnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:43:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WsEMnI5uM+6kXhhMW2lWNTOWRFISpoPibL9nYDeY1aop/0msAnIKjw8t9ugbh2aBynByMRWB+gAX+GMP6MFX+D+Kokg7xwBjTyToSciQo7BdXkczh5WY8XOp3W0zogcPIVXwd5etmJ7FRcMfaii5+PnnfRQdbjX/6HvdmKkExrY=
Message-ID: <447F97A0.3090106@gmail.com>
Date: Fri, 02 Jun 2006 09:42:56 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Ondrej Zajicek <santiago@mail.cz>, "D. Hazelton" <dhazelton@enter.net>,
       Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605302314.25957.dhazelton@enter.net>	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>	 <200605310026.01610.dhazelton@enter.net>	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>	 <20060601092807.GA7111@localhost.localdomain> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
In-Reply-To: <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/1/06, Ondrej Zajicek <santiago@mail.cz> wrote:
>> On Wed, May 31, 2006 at 12:39:19AM -0400, Jon Smirl wrote:
> 
> 7) Obviously part of this is going to exist in user space since some
> cards can only be controlled by VBIOS calls. Has anyone explored using
> the in-kernel protected mode VESA hooks for this?
> 

The protected mode interface provided by the VESA BIOS is only available
for setting the CLUT registers and setting the start address of the
frontbuffer. And this is only available in x86-32.

For the other functions such as mode setting, you need to call the BIOS
in real-mode.  And unless you can persuade Linus to allow this, the
only way to do it is in userspace.

Tony
