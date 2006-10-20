Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWJTOjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWJTOjB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWJTOjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:39:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:11491 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751722AbWJTOjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:39:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Dwayne Grant McConnell <decimal@us.ibm.com>
Subject: Re: Correct way to format spufs file output.
Date: Fri, 20 Oct 2006 16:38:50 +0200
User-Agent: KMail/1.9.5
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <Pine.WNT.4.64.0610182227120.6056@doodlebug> <200610201023.12796.arnd@arndb.de> <Pine.WNT.4.64.0610200848580.5976@dwayne>
In-Reply-To: <Pine.WNT.4.64.0610200848580.5976@dwayne>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610201638.52404.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 October 2006 15:54, Dwayne Grant McConnell wrote:
> I think %0xllx is the way to go. I would even advocate changing 
> signal1_type and signal2_type unless it is actually too dangerous.

There is absolutely no reason why these should be hexadecimal, they
are basically implementing a bool.

> Is there even a case where changing from %llu to %0xllx would break things? 
> Perhaps with the combination of a old library with a new kernel?

Right, a library or some script that has been written assuming there
is no leading 0x.

	Arnd <><
