Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269473AbTCDOLe>; Tue, 4 Mar 2003 09:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269474AbTCDOLe>; Tue, 4 Mar 2003 09:11:34 -0500
Received: from terminus.zytor.com ([63.209.29.3]:4281 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id <S269473AbTCDOLd>;
	Tue, 4 Mar 2003 09:11:33 -0500
Message-ID: <3E64B671.4010504@zytor.com>
Date: Tue, 04 Mar 2003 06:21:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: mem= option for broken bioses
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <b3m840_5e4_1@cesium.transmeta.com> <20030304131855.GE618@zaurus.ucw.cz>
In-Reply-To: <20030304131855.GE618@zaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> This should be commented, somewhere.

It's commented in Documentation/i386/boot.txt as well as the 
kernel-options file.  *ALL* i386 boot loaders need to obey this, 
unfortunately, because of how the initrd protocol was defined.

> Why is mem= option used by boot loader?
> Does your bootloader really parse stuff
> like mem=exactmap?

No, and that's exactly the problem.  A whole bunch of crap was added to 
mem= retroactively (over my explicit objections), and that broke the 
boot protocol.

	-hpa

