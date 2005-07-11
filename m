Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVGKGSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVGKGSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 02:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVGKGSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 02:18:48 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:299 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262245AbVGKGSr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 02:18:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lP3NV4tdo1Ei7xz6m6pKt8CSu67jHdnm1SnJQr7Rof9hsVm8iCOMK0Safh1WVeQMTSikPLxnZx6oAFRwzgdVrRSpI2fLsHkxzTeDghfTCHlu8pyFAQv1iAACqru14JMDr1YG4rG3GipKJ4Xqv0sLH5aotJePiK+/ddUvVgP8Sb8=
Message-ID: <ca992f1105071023184c6eccbd@mail.gmail.com>
Date: Mon, 11 Jul 2005 15:18:47 +0900
From: junjie cai <junjiec@gmail.com>
Reply-To: junjie cai <junjiec@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: problem about Kconfig default value
Cc: junjiec@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello list,
i had a problem about the default value in Kconfig.
for example,i had two Kconfig files:
arch/arm/mach-xxx/Kconfig
    ...
    config CPU_MHZ
    ...

init/Kconfig
    ...
    config PRESET_LPJ
    default 2 if(ARCH_XXX && CPU_MZH)
    default 1 if(ARCH_XXX && !CPU_MZH)
    ...


right after a "make mrproper" it worked just fine in "make menuconfig", 
but then i quit and "make menuconfig" again, the PRESET_LPJ did not
seem to change again while i disable/enabled CPU_MHZ.

is this presumed? or a bug?
thank you very much.
