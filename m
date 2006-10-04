Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWJDHLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWJDHLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWJDHLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:11:48 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:36709 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030456AbWJDHLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:11:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UCK91Bao8vIA2CVVrWnLnx4lge6b8MyY73b7surBGSVAqk5aNIbliIaAG0YNDmnQUYlXo2B7T1JBFfI3MDIHZvLnuyzRYfi2KWqPh92/Xi2nGC7oiiZJ5mvFkclGCqSwqxpmtjHezsQqQc02jiAyOa9tSsLkP6TiU0vRJHIrhRI=
Message-ID: <73d8d0290610040011v190ea16er8cef746f824819dc@mail.gmail.com>
Date: Wed, 4 Oct 2006 08:11:46 +0100
From: "Peter Read" <peter.read@gmail.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Subject: Re: Registration Weakness in Linux Kernel's Binary formats
Cc: "Julio Auto" <mindvortex@gmail.com>,
       "Chase Venters" <chase.venters@clientec.com>,
       goodfellas@shellcode.com.ar,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       endrazine <endrazine@gmail.com>,
       "Stephen Hemminger" <shemminger@osdl.org>, Valdis.Kletnieks@vt.edu,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1E56E1B6-9C2C-4D84-94D6-42B5A87B5739@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18d709710610032108w52d69b17mfa585e40ad2ae72c@mail.gmail.com>
	 <1E56E1B6-9C2C-4D84-94D6-42B5A87B5739@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm thinking of starting a 'security research' firm and pointing out
that if you can physically swap the boot device on a machine and
reboot you can run 'arbitrary code'.

I might also point out the new boot device could have NetBSD on it,
and gloss over the hundreds of other things that would be both
possible and expectedly so...

On 04/10/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Oct 04, 2006, at 00:08:57, Julio Auto wrote:
> > I sincerely think you're all missing the point here.
>
> No, _you're_ missing the point.
>
> > The observation is in fact something that can be used by rootkit
> > writers or developers of other forms of malware.
>
> This attack relies on being able to load an arbitrary attacker-
> defined kernel module.  Full Stop.  If you can load code into
> privileged mode it's game over regardless of what other designs and
> restrictions are in place.  The "default" security model is that only
> root can load kernel code, but using SELinux or other methods it's
> possible to entirely prevent anything from being loaded after system
> boot or written to the kernel or bootloader images.
>
> If the attacker gains kernel code access, it doesn't matter what
> "simply linked list" or whatever other garbage is being used, they
> can just overwrite the existing ELF loader with their shellcode if
> they want.  Or they could insert a filesystem patch which always
> loads a virus into any ELF binary at load.  Or they could just fork a
> kernel thread and run their shellcode there.  Or they could load a
> copy of Windows from the CD drive and boot into that from Linux.
>
> Kernel-level access implies ultimate trust and security, and
> *nothing* is going to change that.
>
> Cheers,
> Kyle Moffett
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
