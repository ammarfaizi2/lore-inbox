Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTKDTr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 14:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTKDTr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 14:47:58 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25742 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261774AbTKDTr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 14:47:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16296.619.825051.532542@alkaid.it.uu.se>
Date: Tue, 4 Nov 2003 20:47:55 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some issues with Acer TravelMate 242
In-Reply-To: <200311042020.26085.cijoml@volny.cz>
References: <200311042020.26085.cijoml@volny.cz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler (volny.cz) writes:
 > Hi,
 > 
 > I have Acer TravelMate 242 serie and I have these problems with 2.4 kernel:
 > 
 > 1) Compiling into kernel Local APIC causes kernel not booting after reboot - 
 > Kernel writes Loading kernel and when finished PC freezes. Removing Local 
 > Apic causes working kernel

Please clarify: does the kernel with local APIC support enabled always
fail to boot, or does it only fail at warm (re)boots?

What exact kernel version are you using? A bug which had the effect
of breaking warm (re)boots on some system was fixed semi-recently.

(Power-management related config options are also significant.
Certain APM options are known to cause problems, for instance.)

Note that many many laptops have buggy BIOSen, making local APIC
usage on those laptops impossible. Pass "nolapic" to the kernel if
you have a buggy machine.

/Mikael
