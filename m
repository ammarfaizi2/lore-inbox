Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279303AbRKSPNo>; Mon, 19 Nov 2001 10:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279317AbRKSPNf>; Mon, 19 Nov 2001 10:13:35 -0500
Received: from wallext.webflex.nl ([212.115.150.250]:22192 "EHLO
	palm.webflex.nl") by vger.kernel.org with ESMTP id <S279303AbRKSPNb>;
	Mon, 19 Nov 2001 10:13:31 -0500
Message-ID: <XFMail.20011119161221.mathijs@knoware.nl>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <01111916225301.00817@nemo>
Date: Mon, 19 Nov 2001 16:12:21 +0100 (CET)
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: RE: x bit for dirs: misfeature?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-Nov-2001 vda wrote:
> Everytime I do 'chmod -R a+rX dir' and wonder are there
> any executables which I don't want to become world executable,
> I think "Whatta hell with this x bit meaning 'can browse'
> for dirs?! Who was that clever guy who invented that? Grrrr"
> 
> Isn't r sufficient? Can we deprecate x for dirs?
> I.e. make it a mirror of r: you set r, you see x set,
> you clear r, you see x cleared, set/clear x = nop?
> 
> Benefits:
> chmod -R go-x dir (ensure there is no executables)
> chmod -R a+r dir (make tree world readable)
> mount -t vfat -o umask=644 /dev/xxx dir
>       (I don't want all files to be flagged as executables there)

This is all userspace:
find . -type d -exec chmod a+rx {} \;

make an alias for it and stop considering changing one of the earliest
unix standards. I'm sure if you really want this policy you can write your
own chmod executable.

        me


-- 
        me
