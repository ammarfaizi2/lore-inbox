Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWIDT3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWIDT3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWIDT3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:29:55 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:39896 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751536AbWIDT3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:29:53 -0400
Message-ID: <44FC7EAE.6020300@free.fr>
Date: Mon, 04 Sep 2006 21:29:50 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: msleep_interruptible vs msleep
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What's the difference between msleep_interruptible and msleep ?
If I understand correctly the main difference between msleep and 
msleep_interruptible is that msleep_interruptible can return if there is 
a pending signal ?

But why if I have a kernel thread that do [1] :

while (true) {
Do some stuff
msleep(1000)
}

the load average is high (near 100%).

and if I use msleep_interruptible the load average is normal.

Does the same applies to wait_event_timeout vs 
wait_event_interruptible_timeout ?

Thanks,

Matthieu CASTET
