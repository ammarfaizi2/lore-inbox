Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263107AbTCTWzz>; Thu, 20 Mar 2003 17:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263111AbTCTWzz>; Thu, 20 Mar 2003 17:55:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2828 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263107AbTCTWzv>; Thu, 20 Mar 2003 17:55:51 -0500
Message-ID: <3E7A4977.5090700@zytor.com>
Date: Thu, 20 Mar 2003 15:06:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t and major/minor split
References: <b5dckh$lv1$1@cesium.transmeta.com> <20030320220901.GR2835@ca-server1.us.oracle.com>
In-Reply-To: <20030320220901.GR2835@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Thu, Mar 20, 2003 at 01:42:41PM -0800, H. Peter Anvin wrote:
> 
>>b) In order to support NFSv2 and other filesystems which only support
>>   a 32-bit dev_t, I suggest we stay within a (12,20)-bit range for as
> 
> 
> 	Hmm, I guess that means dropping ext2/3 for / ;-(
> 

Last I checked, all traditional (inode-based) Unix filesystems,
including ext2/3 used block pointers for dev_t.  There are plenty of
block pointers; 60 bytes worth.

	-hpa

