Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSHVRW4>; Thu, 22 Aug 2002 13:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSHVRWz>; Thu, 22 Aug 2002 13:22:55 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32013 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S314602AbSHVRWX>;
	Thu, 22 Aug 2002 13:22:23 -0400
Date: Thu, 22 Aug 2002 19:36:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: trivial: 2.5.31+bk forgotten endmenu
Message-ID: <20020822193633.C1401@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20020822114128.GA7095@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020822114128.GA7095@riesen-pc.gr05.synopsys.com>; from Alexander.Riesen@synopsys.com on Thu, Aug 22, 2002 at 01:41:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 01:41:28PM +0200, Alex Riesen wrote:
> 
> the forgotten endmenu statement broke xconfig.
Please apply the following patch instead.
It adds a missing comment.

===== drivers/net/appletalk/Config.in 1.5 vs edited =====
--- 1.5/drivers/net/appletalk/Config.in	Wed Aug  7 05:12:59 2002
+++ edited/drivers/net/appletalk/Config.in	Sun Aug 18 20:31:11 2002
@@ -3,6 +3,7 @@
 #
 
 mainmenu_option next_comment
+comment 'Appletalk Devices'
 dep_mbool 'Appletalk interfaces support' CONFIG_DEV_APPLETALK $CONFIG_ATALK
 if [ "$CONFIG_DEV_APPLETALK" = "y" ]; then
    tristate '  Apple/Farallon LocalTalk PC support' CONFIG_LTPC
@@ -17,3 +18,4 @@
       bool '    Appletalk-IP to IP Decapsulation support' CONFIG_IPDDP_DECAP
    fi
 fi
+endmenu
