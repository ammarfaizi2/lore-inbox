Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWF0UKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWF0UKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWF0UKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:10:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:64129 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932564AbWF0UKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:10:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cczzbXVgS085l2VskVcIkNjFEzq5c1Su2gZGa8YjypbVVA2La0gt+c4bMNv+eeHRYz8r13+BAZyUPOJlEMU35lSAlmgbFBza2j+xbB6VxVUNp9NYZ3xQgzBsxpzJFFarRoHz+2NvEZ9R146cc37OgPfDGubKUCtzHUAkQMVWrRY=
Message-ID: <4807377b0606271310h41134de8t8c5f60436d73a988@mail.gmail.com>
Date: Tue, 27 Jun 2006 13:10:02 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: git head x86_64 build breakage
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using a fresh pull of Linus' git, I can't build a kernel right now
I get this:
make O=../2.6.18.obj/ all -j5
  GEN     /home/jbrandeb/2.6.18.obj/Makefile
scripts/kconfig/conf -s arch/x86_64/Kconfig
init/Kconfig:3: unknown option "option"
make[3]: *** [silentoldconfig] Error 1
make[2]: *** [silentoldconfig] Error 2
make[1]: *** [include/config/auto.conf] Error 2
make: *** [all] Error 2

reverting to the v2.6.17 init/Kconfig fixes it.

I kinda stumble around in git, but this appears to be the commit that broke it.
face4374e288372fba67c865eb0c92337f50d5a4

Jesse
