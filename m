Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311615AbSCXRtM>; Sun, 24 Mar 2002 12:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311630AbSCXRtD>; Sun, 24 Mar 2002 12:49:03 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:38404 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311615AbSCXRsr>; Sun, 24 Mar 2002 12:48:47 -0500
Date: Sun, 24 Mar 2002 17:48:39 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Christian Asam <Christian.Asam@chasam.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with serial.c introduced in 2.4.15
Message-ID: <20020324174839.C23492@flint.arm.linux.org.uk>
In-Reply-To: <E16pBIs-00024N-00@mrvdom03.kundenserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 05:57:08PM +0100, Christian Asam wrote:
> The #if 0 and #endif was removed in 2.4.15 and somehow that breaks 
> gpm/genitizer. Having added the "commenting out through $if 0" the 
> tablet works fine again and deactivating the appropriate line in 2.4.18 
> also works.

It sounds like gpm is buggy.  If an application turns off the CREAD flag
and expects to read characters from a TTY, then its asking too much. 8)

       [-]cread
              allow input to be received

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

