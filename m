Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVG0McH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVG0McH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVG0McH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:32:07 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:64236 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262212AbVG0McG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:32:06 -0400
Message-ID: <42E77EB5.8010807@ens-lyon.org>
Date: Wed, 27 Jul 2005 14:31:49 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2 (kbuild broken for external modules)
References: <20050727024330.78ee32c2.akpm@osdl.org> <E1DxkiX-0001FB-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DxkiX-0001FB-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27.07.2005 14:08, Miklos Szeredi a écrit :
>> git-kbuild.patch
> 
> 
> This breaks building of external modules:
> 
>    scripts/Makefile.build:14: /usr/src/linux-2.6.13-rc3-mm2//home/miko/fuse/kernel/Makefile: No such file or directory
>    make[2]: *** No rule to make target `/usr/src/linux-2.6.13-rc3-mm2//home/miko/fuse/kernel/Makefile'.  Stop.
>    make[1]: *** [_module_/home/miko/fuse/kernel] Error 2
>    make[1]: Leaving directory `/usr/src/linux-2.6.13-rc3-mm2'
>    make: *** [all-spec] Error 2

I'm seeing the same probleme here.
It seems to be caused by some $(obj) that have been replaced by
$(srctree)/$(src) in Makefile.{build,clean}.

Regards,
Brice
