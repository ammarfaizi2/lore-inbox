Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbTCDOMf>; Tue, 4 Mar 2003 09:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269482AbTCDOMf>; Tue, 4 Mar 2003 09:12:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48031
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269481AbTCDOMd>; Tue, 4 Mar 2003 09:12:33 -0500
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "rain.wang" <rain.wang@mic.com.tw>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E64A8A5.4EBB5FB3@mic.com.tw>
References: <3E5CEF17.4C014A4C@mic.com.tw>
	 <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
	 <3E5EEDF9.5906D73E@mic.com.tw>  <3E64A8A5.4EBB5FB3@mic.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046791639.10857.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Mar 2003 15:27:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 13:22, rain.wang wrote:
>     I had tested 'hdparm -w /dev/hda' under 2.4.25-pre5-ac1, system
> crashed
> with
> kernel oops message:
>     kernel BUG at ide-iops:1046!
>     ...
> 
>     can this be resolved?

Once I understand what the problems all are yes. The BUG() is good, it
confirms that what we are both seeing is the same thing - the reset is
managing to issue two commands to the controller at the same time.

