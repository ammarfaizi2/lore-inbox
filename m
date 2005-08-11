Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVHKP4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVHKP4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVHKP4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:56:34 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:28228 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932178AbVHKP4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:56:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=PlwHMmd8zPRXaTks4Z+4FibdafaikRGbMyQVLxZzzGLMrnThMzZYBpy1H6/5c64WXck7eTNBAC21QJq8nz8iHY1HkNYR1kNZNijb5ZZonaBxSxcT0ZO09ZhGNPlc/4/rnVGn4I58KfXZEdh7mvEYF6CjFczgxuQUUogyupPMSxk=
Message-ID: <42FB752D.6070101@gmail.com>
Date: Thu, 11 Aug 2005 17:56:29 +0200
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
Organization: hetfield666@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc6-git3 undefined reference on _mntput
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grep _mntput *
namei.c:        _mntput(nd->mnt);
namespace.c:void __mntput(struct vfsmount *mnt)
namespace.c:EXPORT_SYMBOL(__mntput);


  CC      fs/namei.o
fs/namei.c: In function `path_release_on_umount':
fs/namei.c:317: warning: implicit declaration of function `_mntput'


....

   LD      .tmp_vmlinux1
fs/built-in.o: In function `path_release_on_umount':
: undefined reference to `_mntput'
make: *** [.tmp_vmlinux1] Error 1


seems an underscore is missing.
