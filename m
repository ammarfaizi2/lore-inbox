Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRKSPnY>; Mon, 19 Nov 2001 10:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279472AbRKSPnO>; Mon, 19 Nov 2001 10:43:14 -0500
Received: from [195.66.192.167] ([195.66.192.167]:52745 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279113AbRKSPnD>; Mon, 19 Nov 2001 10:43:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mathijs Mohlmann <mathijs@knoware.nl>
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 17:41:50 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011119161221.mathijs@knoware.nl>
In-Reply-To: <XFMail.20011119161221.mathijs@knoware.nl>
MIME-Version: 1.0
Message-Id: <01111917415008.00817@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 15:12, Mathijs Mohlmann wrote:
> On 19-Nov-2001 vda wrote:
> > Everytime I do 'chmod -R a+rX dir' and wonder are there
> > any executables which I don't want to become world executable,
> > I think "Whatta hell with this x bit meaning 'can browse'
> > for dirs?! Who was that clever guy who invented that? Grrrr"
> >
> > Isn't r sufficient? Can we deprecate x for dirs?
> > I.e. make it a mirror of r: you set r, you see x set,
> > you clear r, you see x cleared, set/clear x = nop?
> >
> > Benefits:
> > chmod -R go-x dir (ensure there is no executables)
> > chmod -R a+r dir (make tree world readable)
> > mount -t vfat -o umask=644 /dev/xxx dir
> >       (I don't want all files to be flagged as executables there)
>
> This is all userspace:
> find . -type d -exec chmod a+rx {} \;
>
> make an alias for it and stop considering changing one of the earliest
> unix standards. I'm sure if you really want this policy you can write your
> own chmod executable.

Well, I think you're right. I still think that overloading one bit to have 
two meanings (exec for file, browse for dir) was a bad idea, but it looks 
unsurmountable now to change that. Amount (and tone) of replies proves this.

chmod/mount/.../... workarounds is the best we can do now.

chmod -R [ugoa]+R dir - set r for files, rx for dirs
chmod -R [ugoa]-R dir - remove r for files, rx for dirs
                ^
mount -t vfat -o umask=644,udmask=755 /dev/hdc1 /mnt/hdc1
                           ^^^^^^^^^^
--
vda
