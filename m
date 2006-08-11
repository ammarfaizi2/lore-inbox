Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWHKOW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWHKOW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 10:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWHKOW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 10:22:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:61055 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751127AbWHKOW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 10:22:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g2oQy5kP2n/iz6vYTYqYl6bQX/1bBXhmpI+ROaXT0R+4DMOuCya58rKjKZ/BqxGX1XZSIegVRdmwkXcnKNih/saESodmmQXBXSS+yAzN6k5lYpkTntyUxOwegOrdXzW1Ql+UPupRujoO1zI15GVLwJeGeXEWtuh8qVB9z9MmyVA=
Message-ID: <fc0677e00608110722v7e7c9383s1657ee5fa17c1baa@mail.gmail.com>
Date: Fri, 11 Aug 2006 10:22:53 -0400
From: "Chris Lu" <zagarus@gmail.com>
To: "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: Patch that breaks Cardbus support on HP zv5460us laptop
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <44DC1994.5070703@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fc0677e00608102120h72caf30dvfa2b709a19738170@mail.gmail.com>
	 <44DC1994.5070703@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did try pci=assign-busses before unapplying the patch, which didn't
help anything.

On 8/11/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> Chris Lu wrote:
> > Hi All,
> >
> > Using git-bisect I found the patch that breaks cardbus support on my
> > HP zv5460 laptop. This was applied between 2.6.14-rc2 and -rc3;
> > reversing the patch on 2.6.17.7 makes Cardbus work where it formerly
> > did not. sha1sum of the patch is:
> >
> > 12f44f46bc9c6dc79255e661b085797af395d8da
> >
> > I have attached lspci -vvv output; please ask if you need more info.
> > (lspci output is with Cardbus card inserted.)
>
> Did you try the "pci=assign-busses" option before you reverted that patch? Is
> your system running a 32- or 64-bit system?
>
> This breakage needs to be sent to linux-kernel@vger.kernel.org. As you have seen
> from the short log accompanying that patch, it was signed-off-by Andrew Morton
> and Linus Torvalds - you cannot get any higher than that.
>
> I have some personal interest in this problem as the patch in question fixed a
> problem that kept my machine from booting with any cardbus card in the adapter.
>
> Larry
>
>
>
