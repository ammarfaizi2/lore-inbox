Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUBYQIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUBYQIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:08:42 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:1289 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S261385AbUBYQIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:08:35 -0500
Date: Wed, 25 Feb 2004 17:08:33 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: i2c on alpha - used but not available in 2.6.3
Message-ID: <20040225160833.GA5803@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are i2c drivers valid on alpha?
They are not available because drivers/i2c/Kconfig (nor drivers/Kconfig
which includes it) is not included from arch/alpha/Kconfig.

But many drivers making use of i2c can be enabled - and build with
unresolved symbols (about 50 warnings - mostly in media/video drivers).

I checked that adding including of drivers/i2c/Kconfig to arch/alpha/Kconfig
everything build and all remaining unresolved symbols fade away.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/
