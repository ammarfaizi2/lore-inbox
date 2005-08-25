Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVHYEao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVHYEao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVHYEao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:30:44 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:24565 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964785AbVHYEan convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:30:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GmrqAmHSEvlzZAWfNDk4CoIeecdL+q8S/cQwi+/APqo8m3yLvGjhj3YHQIAByBog+OrwZdfHyoG69C5O/Wvsa0M7xZtVO8WeK+iOsG4QsToCOVPJ2OIwG3QdY0ih54emTH85M/qbbgK+ADTazL3IR4XX3OGjk0Crp3As0HASZU4=
Message-ID: <88ee31b705082421303697aef7@mail.gmail.com>
Date: Thu, 25 Aug 2005 13:30:41 +0900
From: Jerome Pinot <ngc891@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [KCONFIG] Can't compile 2.6.12 without Gettext
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I didn't see much informations about this.

It's not possible to "make {,menu}config" and even to compile a 2.6.12
kernel if there is no or partially installed Gettext on the system.

Full Gettext is *required* to launch the kbuild scripts since the
modifications to add i18n to the config scripts.

Not all system have gettext, I'm thinking about small or embedded
system with specific toolchain. For example, uClibc is widely used but
as still a partial nls support.

Anyway, this should not be required for compiling a kernel. At least
an option to pass to make which override the default behavior could
solve the issue.

Moreover, the script doesn't do any sanity check about the system
(there is no configure script of course) and just try to catch the
gettext binaries he founds first. There is a hard-coded filename too.

Seems dangerous to me and should not be allowed by default.

Am I misleading ?

-- 
Jerome Pinot
ftp://ngc891.blogdns.net/pub
