Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbSLTA04>; Thu, 19 Dec 2002 19:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267664AbSLTA04>; Thu, 19 Dec 2002 19:26:56 -0500
Received: from mail.fastwire.com ([216.7.221.2]:65289 "EHLO fastwire.com")
	by vger.kernel.org with ESMTP id <S267659AbSLTA0z>;
	Thu, 19 Dec 2002 19:26:55 -0500
Subject: Modules loading when hardcoded
From: Jason Lixfeld <jlixfeld@andromedas.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1040344418.1425.44.camel@housekat.fastvibe.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 19:33:39 -0500
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 172.17.7.137
X-Return-Path: jlixfeld@andromedas.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: jlixfeld@andromedas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had 2.4.20 compiled with ext3 as a module.  ran did the standard
compile including make modules ; make modules_install but when I
rebooted, the bootup failed telling me that the modules were compiled
for 2.4.18 and being run on 2.4.20.  Stranger still, the path was
/lib/jbd.o and the modules aren't even there, they are in the standard
module path of /usr/lib/modules/2.4.20

I nuked the 2.4.20 modules and re-ran make modules ; make
modules_install for 2.4.20 in hopes that it would help but it didn't.

I re-compiled the kernel and hard coded ext3 and that allowed me to boot
properly but I still got the errors about version problems on ext3.o and
jbd.o.  Why are they still trying to get referenced and why are they
still trying to get referenced with the old version?!


