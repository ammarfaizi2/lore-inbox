Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262723AbTCYQ1i>; Tue, 25 Mar 2003 11:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262754AbTCYQ1i>; Tue, 25 Mar 2003 11:27:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22281 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262723AbTCYQ1h>; Tue, 25 Mar 2003 11:27:37 -0500
Date: Tue, 25 Mar 2003 16:38:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Geoffrey Lee <glee@gnupilgrims.org>
Cc: linux-kernel@vger.kernel.org, pleb@cse.unsw.edu.au
Subject: Re: [Patch] [arm] support older plebs
Message-ID: <20030325163843.D24418@flint.arm.linux.org.uk>
Mail-Followup-To: Geoffrey Lee <glee@gnupilgrims.org>,
	linux-kernel@vger.kernel.org, pleb@cse.unsw.edu.au
References: <20030325161358.GA30538@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030325161358.GA30538@anakin.wychk.org>; from glee@gnupilgrims.org on Wed, Mar 26, 2003 at 12:13:58AM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 12:13:58AM +0800, Geoffrey Lee wrote:
> The PLEB is a SA-1100-based ARM computer developed at CSE at the
> University of New South Wales.  I have discovered some of the earlier
> models would not set register 1 properly, which was required for Linux
> to boot.  This was inside their (very old) kernel tree but which they 
> never submitted for inclusion (?)  It is a Photon1 with catapult
> bootloader combination.

I've been killing these - people should really be passing the right
value of r1 to the kernel.  Think what happens when 200 different
machine types add these 3 lines.

A saner solution would be to define this appropriately if we're only
being built for one platform.

BTW, please send ARM stuff to the linux-arm-kernel list.  See
http://lists.arm.linux.org.uk/mailman/listinfo/

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

